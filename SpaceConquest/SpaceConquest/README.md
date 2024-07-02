 # SpaceConquest
 ## The Scenario 
 > You're the captain on a spaceship venturing through an asteroid field. Your goal is to navigate safely by dodging asteroids and collecting valuable minerals.

## Demo
https://github.com/FlavianEng/Swift-playgrounds/assets/63726994/75243b54-a7e9-4f15-97e3-d098ac8b243b



 ## Classes 
 ### Spaceship
    **Properties:**
        - name (_String_): Name of the spaceship.
        - health (_Int_): Current health of the spaceship.
        - cargoHold (_Dictionary<String, Int>_): Stores collected minerals (mineral name as key, quantity as value).
    **Methods:**
        - init(name: _String_): Initializes the spaceship with a name and sets starting values for health and an empty cargoHold.
        - takeDamage(amount: _Int_): Decreases health by the given amount.
        - collectMineral(name: _String_, quantity: _Int_): Adds the specified mineral and quantity to the cargoHold, or updates the quantity if it already exists.
        - displayStatus(): Prints information about the spaceship's name, health, and cargo hold contents.
 
 ### Mineral
     **Properties:**
         - name (_String_): Name of the mineral.
         - value (_Int_): Value of the mineral.
     
     **Methods:**
        - init(name: _String_, value: _Int_): Initializes the mineral with a name and value.
 
## Tasks
 - [x] Use the Spaceship initializer to create a spaceship with a desired name.
 - [x] Simulate the ongoing space exploration. (description below)
   > While exploring, present the player with options (e.g., "Navigate", "View Cargo", "Exit").
   > Based on the user's choice, call appropriate methods on the spaceship object (e.g., navigate - simulate dodging asteroids with a chance of taking damage, view cargo - call displayStatus, exit - terminate the loop).       
 - [x] Introduce mineral collection events during navigation (randomly generate mineral types and quantities, use collectMineral on the spaceship) – maybe with a chance of failing.

 * Bonus *
    - [x] Add a Mineral class to represent different minerals with varying values.
    - [x] Expand the navigation logic to include different difficulty levels with varying chances of encountering asteroids and minerals.
    - [x] Introduce a scoring system based on collected minerals and remaining health.
 
### Generation
```zsh
swift build -c release --show-bin-path
```
