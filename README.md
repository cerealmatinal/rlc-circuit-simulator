# RLC Circuit Simulator in Prolog:
### This project is an RLC circuit simulator implemented in Prolog. The circuit consists of a voltage source (VL), a resistor (VR), a capacitor (VC), and an inductor (VL). The simulator divides time into small time increments (DeltaT) and calculates the state of the system at each point in time using the differential equations that describe the behavior of the circuit.

## Pre-requisites

### To run this project, you will need to have SWI-Prolog installed on your computer. You can download SWI-Prolog at https://www.swi-prolog.org/Download.html.

## How to use

### Open the terminal or command prompt on your computer. Navigate to the folder where you saved the project files. Launch SWI-Prolog by typing swipl in the terminal and pressing Enter. Load the rlc_series.pl file by typing [rlc_series]. and pressing Enter. Run the RLC circuit simulator with the simulate_rlc_series(T, DeltaT) predicate, where T is the final simulation time in seconds and DeltaT is the time interval in seconds between each calculation of the system state. For example, to simulate the circuit for 10 seconds with time intervals of 0.01 seconds, type simulate_rlc_series(10, 0.01). and press Enter.

