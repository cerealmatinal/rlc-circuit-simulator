voltage_source(1).    
resistance(100).      
inductance(1e-6).    
capacitance(1e-6).    

current(V, R, I) :- I is V / R.

voltage(I, R, V) :- V is I * R.

% y = [I, Vc]
inductor(T0, Y0, DeltaT, T, Y) :-
    f_inductor(T0, Y0, F0),
    Y1 is Y0 + DeltaT * F0,
    T1 is T0 + DeltaT,
    inductor(T1, Y1, DeltaT, T, Y1, Y).
inductor(T, Y, _, T, Y, _).

f_inductor(T, [I, Vc], [Di, Dvc]) :-
    voltage_source(Vs),
    resistance(R),
    inductance(L),
    current(I, R, Ir),
    Dvc is -1 / L * Ir,
    Di is Vs / L - Vc / L - R / L * Ir.

% y = [V, Ic]
capacitor(T0, Y0, DeltaT, T, Y) :-
    f_capacitor(T0, Y0, F0),
    Y1 is Y0 + DeltaT * F0,
    T1 is T0 + DeltaT,
    capacitor(T1, Y1, DeltaT, T, Y1, Y).
capacitor(T, Y, _, T, Y, _).

f_capacitor(T, [V, Ic], [Dv, Dic]) :-
    voltage_source(Vs),
    resistance(R),
    capacitance(C),
    voltage(V, R, Ic),
    Dic is C / R * Dv,
    Dv is -1 / (R * C) * V + 1 / (R * C) * Vs.

% y = [V, I]
resistor(T0, Y0, DeltaT, T, Y) :-
    f_resistor(T0, Y0, F0),
    Y1 is Y0 + DeltaT * F0,
    T1 is T0 + DeltaT,
    resistor(T1, Y1, DeltaT, T, Y1, Y).
resistor(T, Y, _, T, Y, _).

f_resistor(_, [_, I], [0, Di]) :-
    resistance(R),
    voltage_source(Vs),
    current(Vs, R, I),
    Di is 0.

state(Time, [VL, VC, VR, IL, IC, IR]) :-
    inductor(0, [IL, VC], 1e-6, Time, [_, IL1, VC1]),
    capacitor(0, [VC1, IC], 1e-6, Time, [_, VC2, IC1]),
    resistor(0, [VC2, IR], 1e-6, Time, [_, _, IR1]),
    voltage_source(Vs),
    VL is Vs,
    VR is IR1 * R.

print_state(Time, State) :-
    state(Time, State),
    format("Time: ~w\nVL: ~w\nVC: ~w\nVR: ~w\nIL: ~w\nIC: ~w\nIR: ~w\n\n", [Time|State]).

simulate_rlc_series(T, DeltaT) :-
    Time is 0,
    EndTime is T,
    repeat,
    print_state(Time, _),
    Time1 is Time + DeltaT,
    Time1 > EndTime,
    !.
