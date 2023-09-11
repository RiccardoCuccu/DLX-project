# DLX-project
DLX processor from RTL down to physical design

## Simulation
### Using the `runsim.sh` script

The `runsim.sh` script is designed to manage the simulation process for the DLX project. It allows you to specify the test file to use for simulation and whether to run the simulation in the background or not.

#### How to Run

To run the script, navigate to the directory `dlx/sim` containing `runsim.sh` and execute it with the following command:

```bash
./runsim.sh
```

To run the script again within the QuestaSim program, the following command:

```bash
do resim.tcl
```

#### Flags

- `-f`: Specify the test filename. By default, the filename is `test.asm`.
  ```bash
  ./runsim.sh -f mytest.asm
  ```
  
- `-b`: Choose whether to run the simulation in the background (`y` for yes, `n` for no). By default, it runs in the background.
  ```bash
  ./runsim.sh -b n
  ```
  
#### Examples

1. To run the default test (`test.asm`) in the background:

    ```bash
    ./runsim.sh
    ```

2. To run a custom test file (`mytest.asm`) in the background:

    ```bash
    ./runsim.sh -f mytest.asm
    ```
  
3. To run the default test (`test.asm`) in the foreground:

    ```bash
    ./runsim.sh -b n
    ```
  
4. To run a custom test file (`mytest.asm`) in the foreground:

    ```bash
    ./runsim.sh -f mytest.asm -b n
    ```
  
5. To run a custom test file (`mytest.asm`) in the background:

    ```bash
    ./runsim.sh -f mytest.asm -b y
    ```

By following these examples, you can easily run the simulation process with different test files and background settings.

## Synthesis
### Using the `runsyn.sh` script

The `runsyn.sh` script is designed to manage the synthesis process for the DLX project.

#### How to Run

To run the script, navigate to the directory `dlx/syn` containing `runsyn.sh` and execute it with the following command:

```bash
./runsyn.sh
```
