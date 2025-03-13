## 1. General Info
This project is a re-creation of the classic Pac-Man game fully implemented in 8086 Assembly in TEXT-MODE. The game aims to simulate the nostalgic gameplay of the original Pac-Man, while providing an opportunity to work with low-level programming and system architecture concepts. The game runs in a terminal environment using text characters to represent game elements.

## Project Contains:
- **Sound Effects:** Basic sound effects, like when Pac-Man eats a pellet or is caught by a ghost.
- **Main Menu:** An interactive menu to start the game, adjust settings, and choose difficulty levels.
- **Difficulty Levels:** Three difficulty levels that affect the number of ghosts.
- **Score Counter:** Displays the current score, updated as the player eats pellets and avoids ghosts.
- **Game Mechanics:** The player controls Pac-Man through the maze, collecting dots, avoiding ghosts, and earning points.
- **Maze Layout:** The game features unique Pac-Man maze, designed using simple text characters.

## Setup
To run the game, the project is fully runnable using TASM (Turbo Assembler) and DOSBox, which is an x86 emulator. The game runs in a DOS environment, and it’s recommended to set up DOSBox for compatibility.

### Requirements:
- **TASM (Turbo Assembler):** To compile the assembly code.
- **DOSBox:** To emulate the 8086 environment.
### Instructions:
- Install TASM and DOSBox on your machine.
- Compile the assembly code using TASM.
```bash
tasm pacman.asm
tlink pacman.obj
```
- Run the compiled executable through DOSBox to launch the game.

## Screenshots

<p align="center">
  <img src="https://github.com/VoxeveR/pacman-x8086-assembly/assets/116713024/388a3d29-19b4-4c39-b8f8-48cc0c7a6739" />
</p>

<p align="center">
  <img src="https://github.com/VoxeveR/pacman-x8086-assembly/assets/116713024/e05c5d72-3761-40d8-b248-e1be16c23750" />
</p>
