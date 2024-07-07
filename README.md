## Project Description

In this project, I am implementing the AI module for a gold digger robot using Haskell. The robot operates within a 4x4 grid environment. Each cell in this grid can either be empty, contain the robot, or contain gold. The robot can move in all four cardinal directions and dig up gold if it is in the same cell. The main objective is to compute a sequence of actions for the robot to collect all the gold in the grid.

---

## Example

Given the following grid:

```
0 1 2 3
0
1    G
2    G
3 R
```

Where `R` is the robot starting at (3,0) and `G` represents gold at positions (2,2) and (1,2), a possible sequence of actions would be:
```
["up", "right", "right", "dig", "up", "dig"]
```

---

## Type Definitions

### 1. Cell
```haskell
type Cell = (Int, Int)
```
A `Cell` represents a position on the grid with the first coordinate indicating the row and the second coordinate indicating the column.

### 2. MyState
```haskell
data MyState = Null | S Cell [Cell] String MyState
```
The `MyState` type represents the state of the robot:
- `Null`: Represents an invalid state.
- `S Cell [Cell] String MyState`: 
  - `Cell`: The robot's position.
  - `[Cell]`: A list of gold positions remaining.
  - `String`: The last action taken to reach this state.
  - `MyState`: The parent state (previous state before the last action).

Example of the initial state:
```haskell
S (3,0) [(2,2),(1,2)] "" Null
```

---

## Required Functions

### 1. Robot Actions

#### `up`
Moves the robot up. Returns `Null` if the move is out of grid bounds.
```haskell
up :: MyState -> MyState
```

#### `down`
Moves the robot down. Returns `Null` if the move is out of grid bounds.
```haskell
down :: MyState -> MyState
```

#### `left`
Moves the robot left. Returns `Null` if the move is out of grid bounds.
```haskell
left :: MyState -> MyState
```

#### `right`
Moves the robot right. Returns `Null` if the move is out of grid bounds.
```haskell
right :: MyState -> MyState
```

#### `dig`
Digs for gold in the current cell. Returns `Null` if no gold is present.
```haskell
dig :: MyState -> MyState
```

### 2. Solution Generation

#### `isGoal`
Checks if the current state has no more gold to dig up.
```haskell
isGoal :: MyState -> Bool
```

#### `nextMyStates`
Generates the next possible states from the current state.
```haskell
nextMyStates :: MyState -> [MyState]
```

#### `search`
Searches for the goal state starting from a list of states.
```haskell
search :: [MyState] -> MyState
```

#### `constructSolution`
Constructs a sequence of actions to reach a given state from the initial state.
```haskell
constructSolution :: MyState -> [String]
```

#### `solve`
Computes the sequence of actions from the initial robot position to collect all the gold.
```haskell
solve :: Cell -> [Cell] -> [String]
```

---

## Example Usage

To solve for the initial position of the robot `(3,0)` and gold positions `[(2,2), (1,2)]`, call the `solve` function:
```haskell
solve (3,0) [(2,2),(1,2)]
-- Output: ["up", "right", "right", "dig", "up", "dig"]
```

---

## Acknowledgments
- Special thanks to the Haskell community for their support and resources.

For more information, refer to the individual function implementations and their detailed comments in the code file.
