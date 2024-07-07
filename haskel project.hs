-- A Cell represents a position on the grid
type Cell = (Int, Int)

-- The MyState structure represents the state of the robot
data MyState = Null 
             | S Cell [Cell] String MyState 
             deriving (Show, Eq)

-- Move the robot up
up :: MyState -> MyState
up Null = Null
up (S (x, y) golds action parent)
  | x == 0    = Null
  | otherwise = S (x-1, y) golds "up" (S (x, y) golds action parent)

-- Move the robot down
down :: MyState -> MyState
down Null = Null
down (S (x, y) golds action parent)
  | x == 3    = Null
  | otherwise = S (x+1, y) golds "down" (S (x, y) golds action parent)

-- Move the robot left
left :: MyState -> MyState
left Null = Null
left (S (x, y) golds action parent)
  | y == 0    = Null
  | otherwise = S (x, y-1) golds "left" (S (x, y) golds action parent)

-- Move the robot right
right :: MyState -> MyState
right Null = Null
right (S (x, y) golds action parent)
  | y == 3    = Null
  | otherwise = S (x, y+1) golds "right" (S (x, y) golds action parent)

-- Dig the gold at the robot's current position
dig :: MyState -> MyState
dig Null = Null
dig (S pos golds action parent)
  | pos `elem` golds = S pos (filter (/= pos) golds) "dig" (S pos golds action parent)
  | otherwise        = Null

-- Check if the current state is the goal state
isGoal :: MyState -> Bool
isGoal (S _ golds _ _) = null golds
isGoal Null = False

-- Generate the next possible states from the current state
nextMyStates :: MyState -> [MyState]
nextMyStates state = filter (/= Null) [up state, down state, left state, right state, dig state]

-- Search for the goal state using BFS
search :: [MyState] -> MyState
search [] = Null
search (x:xs)
  | isGoal x  = x
  | otherwise = search (xs ++ nextMyStates x)

-- Construct the solution sequence from the final state
constructSolution :: MyState -> [String]
constructSolution Null = []
constructSolution (S _ _ action Null) = []
constructSolution (S _ _ action parent) = constructSolution parent ++ [action]

-- Solve the problem given the initial position of the robot and the gold positions
solve :: Cell -> [Cell] -> [String]
solve start golds = constructSolution finalState
  where initialState = S start golds "" Null
        finalState = search [initialState]
