--initialization
    -- import dependencies
        local botTools = { _version = "1.0.0" }
        
    --initialize GLBL table if needed
        if GLBL == nil then
            GLBL = {}
        end

    --initialize SCRIPT table
    --Stores global variables for just this script
        local SCRIPT = {}

    -- define player movement speeds (in m/s)
        SCRIPT.sneakingSpeed = 1.31
        SCRIPT.walkingSpeed = 4.317
        SCRIPT.sprintSpeed = 5.612
        SCRIPT.sprintJumpingSpeed = 7
        SCRIPT.sprintJumpingRooflessIceSpeed = 9.23
        SCRIPT.sprintJumpingIceSpeed = 16.9

--function declarations
    function botTools.lookAtCenter(x,y,z)
        --function initialization
            --initialize function table
                local FUNC = {}
            --store arguments in locally scoped table for scope safety
                FUNC.x = x
                FUNC.y = y
                FUNC.z = z

        --lookAt() is an Advanced Macros API function
        lookAt(FUNC.x+0.5, FUNC.y+0.5, FUNC.z+0.5)
    end

    function botTools.lookTowards(x,z)
        --function initialization
            --initialize function table
                local FUNC = {}
            --store arguments in locally scoped table for scope safety
                FUNC.x = x
                FUNC.z = z

        FUNC.pX, FUNC.pY, FUNC.pZ = getPlayerPos()

        botTools.lookAtCenter(FUNC.x,FUNC.pY+1,FUNC.z)
    end

    function botTools.summonItem(sitem, prefSlot, minDura)
        --function initialization
            --initialize function table
                local FUNC = {}
            --store arguments in locally scoped table for scope safety
                FUNC.sitem = sitem
                FUNC.prefSlot = prefSlot or 9
                FUNC.minDura = minDura or -1

        FUNC.inv = openInventory()
        FUNC.map = FUNC.inv.mapping.inventory
    
        --select FUNC.item if it's in hotbar
            for i,j in pairs(FUNC.map.hotbar) do
                -- store args in known scope safe table
                    FUNC.i, FUNC.j = i,j

                FUNC.item = FUNC.inv.getSlot(FUNC.j)
                -- If hotbar Item is an axe with durability
                if FUNC.item and (FUNC.item.id==FUNC.sitem and((FUNC.item.maxDmg - FUNC.item.dmg)> FUNC.minDura)) then
                    setHotbar(FUNC.i)
                    sleep(100)
                    return FUNC.j
                end
            end
        
        -- select FUNC.item if it's in inventory  
            for i,j in pairs(FUNC.map.main) do
                -- store args in known scope safe table
                    FUNC.i, FUNC.j = i,j

                FUNC.item = FUNC.inv.getSlot(FUNC.j)
                -- If inventory Item is an axe with durability 
                if FUNC.item and (FUNC.item.id==FUNC.sitem and((FUNC.item.maxDmg - FUNC.item.dmg)> FUNC.minDura))  then
                    setHotbar(FUNC.prefSlot)
                    sleep(100)
                    FUNC.p = FUNC.map.hotbar[FUNC.prefSlot]
                    FUNC.inv.click(FUNC.j)
                    sleep(100)
                    FUNC.inv.click(FUNC.p)
                    sleep(100)
        
                    if FUNC.inv.getHeld() then
                        FUNC.inv.click(FUNC.j)
                        sleep(100)
                    end
        
                    return FUNC.prefSlot
                end
            end
        return false
    end

    function botTools.itemInInventory(sitem)
        --function initialization
            --initialize function table
                local FUNC = {}
            --store arguments in locally scoped table for scope safety
                FUNC.sitem = sitem

        -- set up inventory for reading
            FUNC.inv = openInventory()
            FUNC.map = FUNC.inv.mapping.inventory

        FUNC.itemCount = 0

        --count FUNC.sitem in hotbar
            for i,j in pairs(FUNC.map.hotbar) do
                -- store args in known scope safe table
                    FUNC.i, FUNC.j = i,j

                FUNC.item = FUNC.inv.getSlot(FUNC.j)
                -- If hotbar Item is an axe with durability
                if FUNC.item and FUNC.item.id==FUNC.sitem then
                    FUNC.itemCount = FUNC.itemCount + 1
                end
            end

        -- count FUNC.sitem in inventory  
            for i,j in pairs(FUNC.map.main) do
                -- store args in known scope safe table
                    FUNC.i, FUNC.j = i,j

                FUNC.item = FUNC.inv.getSlot(FUNC.j)
                -- If hotbar Item is an axe with durability
                if FUNC.item and FUNC.item.id==FUNC.sitem then
                    FUNC.itemCount = FUNC.itemCount + 1
                end
            end

        -- return result
            if FUNC.itemCount ~= 0 then
                return FUNC.itemCount
            else
                return false
            end
    end

    function botTools.eatIfHungery()
        --function initialization
            --initialize function table
                local FUNC = {}

        --declare local function variables
            FUNC.player = getPlayer()
            FUNC.minfood = 12
            -- declare list of foods
                FUNC.listOfFood = {}
                -- cooked
                    table.insert(FUNC.listOfFood, "minecraft:apple")
                    table.insert(FUNC.listOfFood, "minecraft:mushroom_stew")
                    table.insert(FUNC.listOfFood, "minecraft:bread")
                    table.insert(FUNC.listOfFood, "minecraft:cooked_porkchop")
                    table.insert(FUNC.listOfFood, "minecraft:cooked_cod")
                    table.insert(FUNC.listOfFood, "minecraft:cooked_salmon")
                    table.insert(FUNC.listOfFood, "minecraft:cookie")
                    table.insert(FUNC.listOfFood, "minecraft:melon_slice")
                    table.insert(FUNC.listOfFood, "minecraft:cooked_beef")
                    table.insert(FUNC.listOfFood, "minecraft:cooked_chicken")
                    table.insert(FUNC.listOfFood, "minecraft:carrot")
                    table.insert(FUNC.listOfFood, "minecraft:baked_potato")
                    table.insert(FUNC.listOfFood, "minecraft:pumpkin_pie")
                    table.insert(FUNC.listOfFood, "minecraft:cooked_rabbit")
                    table.insert(FUNC.listOfFood, "minecraft:rabbit_stew")
                    table.insert(FUNC.listOfFood, "minecraft:cooked_mutton")
                    table.insert(FUNC.listOfFood, "minecraft:beetroot_soup")
                    table.insert(FUNC.listOfFood, "minecraft:sweet_berries")
                -- raw
                    table.insert(FUNC.listOfFood, "minecraft:porkchop")
                    table.insert(FUNC.listOfFood, "minecraft:cod")
                    table.insert(FUNC.listOfFood, "minecraft:salmon")
                    table.insert(FUNC.listOfFood, "minecraft:tropical_fish")
                    table.insert(FUNC.listOfFood, "minecraft:beef")
                    table.insert(FUNC.listOfFood, "minecraft:chicken")
                    table.insert(FUNC.listOfFood, "minecraft:potato")
                    table.insert(FUNC.listOfFood, "minecraft:rabbit")
                    table.insert(FUNC.listOfFood, "minecraft:mutton")
                    table.insert(FUNC.listOfFood, "minecraft:beetroot")
                -- food the bot doesnt eat
                    -- table.insert(FUNC.listOfFood, "minecraft:golden_apple")
                    -- table.insert(FUNC.listOfFood, "minecraft:enchanted_golden_apple")
                    -- table.insert(FUNC.listOfFood, "minecraft:pufferfish")
                    -- table.insert(FUNC.listOfFood, "minecraft:dried_kelp")
                    -- table.insert(FUNC.listOfFood, "minecraft:rotten_flesh")
                    -- table.insert(FUNC.listOfFood, "minecraft:spider_eye")
                    -- table.insert(FUNC.listOfFood, "minecraft:poisonous_potato")

        -- exit function if not hungry
            if FUNC.player.hunger >= FUNC.minfood then
                return true
            end
        -- eat foods until full
            for i,j in pairs(FUNC.listOfFood) do
                -- store args in known scope safe table
                    FUNC.food = j

                    -- eat given food till no longer hungry or food is gone
                        while botTools.itemInInventory(FUNC.food) and FUNC.player.hunger < FUNC.minfood do
                            botTools.summonItem(FUNC.food, 9)
                            use(-1) -- eat forever
                            sleep(100)
                            -- leave at end of while loop
                                FUNC.player = getPlayer()
                        end

                    -- end function if no longer hungry
                        FUNC.player = getPlayer()
                        if FUNC.player.hunger >= FUNC.minfood then
                            -- stop eating
                            use(1)
                            return true 
                        end
            end

        -- failed to find enough food to satisfy hunger
            -- stop eating
                use(1)
            return false
    end

    function botTools.freezeAllMotorFunctions()
        --function initialization
            --initialize function table
                local FUNC = {}
        -- stop walking
            forward(1)
            right(1)
            left(1)
            back(1)
        --stop attacking
            --might not work if you pass a 0
            attack(1)
        --stop right clicking
            --might not work if you pass a 0
            use(1)
        -- stop moving head (if it is moving)
        --look can be set to be done in a certain amount of time
            FUNC.player = getPlayer()
            look(FUNC.player.yaw, FUNC.player.pitch)

        -- give time for actions to have taken effect
        waitTick()
    end

    --for jumping if slower than desired speed

        function botTools.initializeJumpIfSlowerThan()
            --get position for speed measurment
                GLBL.JIST_tooSlowCount = 0
                GLBL.JIST_lastPX, GLBL.JIST_lastPY, GLBL.JIST_lastPZ = getPlayerPos()
                GLBL.JIST_lastTimePositionTaken = os.time()
        end

        function botTools.jumpIfSlowerThan(speed)
            --function initialization
                --initialize function table
                    local FUNC = {}
                --store arguments in locally scoped table for scope safety
                    FUNC.speed = speed

            --jump if slower than expected
                    --get position for speed measurment
                    FUNC.curPX, FUNC.curPY, FUNC.curPZ = getPlayerPos()
                    if (compTools.distanceBetweenPoints(FUNC.curPX,FUNC.curPY,FUNC.curPZ, GLBL.JIST_lastPX,GLBL.JIST_lastPY,GLBL.JIST_lastPZ) / os.difftime(os.time(), GLBL.JIST_lastTimePositionTaken)) < (0.7 * FUNC.speed) then
                        GLBL.JIST_tooSlowCount = GLBL.JIST_tooSlowCount + 1
                        if GLBL.JIST_tooSlowCount >= 2 then
                            -- sneak for a bit
                            -- allows bot to go beneath any upper half-slabs placed at head height
                                sneak(25)
                                waitTick()
                                sleep(25)
                            jump()
                            sleep(100)
                        end
                    else
                        GLBL.JIST_tooSlowCount = 0
                    end
                GLBL.JIST_lastPX = FUNC.curPX
                GLBL.JIST_lastPY = FUNC.curPY
                GLBL.JIST_lastPZ = FUNC.curPZ
                GLBL.JIST_lastTimePositionTaken = os.time()
        end

    --traveling to points

        function botTools.sneakToPoint(x,y,z)
            --function initialization
                --initialize function table
                    local FUNC = {}
                --store arguments in locally scoped table for scope safety
                    FUNC.x = x
                    FUNC.y = y
                    FUNC.z = z

            --declare local function variables
                FUNC.arrivedDistance = 0.5

            -- sneak towards point
                botTools.initializeJumpIfSlowerThan()
                while(compTools.playerhorizontalSquareDistanceBetween(FUNC.x + 0.5, FUNC.z + 0.5) > FUNC.arrivedDistance or compTools.playerVerticalSquareDistanceBetween(FUNC.y) > 10)do
                    botTools.eatIfHungery()
                    botTools.lookTowards(FUNC.x,FUNC.z)
                    sprint(false)
                    sneak(-1)
                    forward(-1)
                    sleep(50)
                    botTools.jumpIfSlowerThan(SCRIPT.sneakingSpeed)
                end

            -- stop traveling
                forward(1)
                sneak(1)
                waitTick()
        end

        function botTools.sprintToPoint(x,y,z)
            --function initialization
                --initialize function table
                    local FUNC = {}
                --store arguments in locally scoped table for scope safety
                    FUNC.x = x
                    FUNC.y = y
                    FUNC.z = z

            --declare local function variables
                FUNC.arrivedDistance = 0.5
                FUNC.slowDownDistance = 2
            while(compTools.playerhorizontalSquareDistanceBetween(FUNC.x + 0.5, FUNC.z + 0.5) > FUNC.arrivedDistance or compTools.playerVerticalSquareDistanceBetween(FUNC.y) > 10)do
                botTools.eatIfHungery()
                -- walk twords point
                    if compTools.playerhorizontalSquareDistanceBetween(FUNC.x + 0.5, FUNC.z + 0.5) < FUNC.slowDownDistance then
                        -- walk
                            botTools.initializeJumpIfSlowerThan()
                            while(compTools.playerhorizontalSquareDistanceBetween(FUNC.x + 0.5, FUNC.z + 0.5) > FUNC.arrivedDistance or compTools.playerVerticalSquareDistanceBetween(FUNC.y) > 10) do
                                botTools.eatIfHungery()
                                botTools.lookTowards(FUNC.x,FUNC.z)
                                forward(-1)
                                sprint(false)
                                sleep(50)
                                botTools.jumpIfSlowerThan(SCRIPT.walkingSpeed)
                            end
                    else
                        -- run
                            botTools.initializeJumpIfSlowerThan()
                            while(compTools.playerhorizontalSquareDistanceBetween(FUNC.x + 0.5, FUNC.z + 0.5) > FUNC.slowDownDistance) do
                                botTools.eatIfHungery()
                                botTools.lookTowards(FUNC.x,FUNC.z)
                                forward(-1)
                                sprint(true)
                                sleep(50)
                                botTools.jumpIfSlowerThan(SCRIPT.walkingSpeed)
                            end
                    end
            end
            -- stop traveling
                forward(1)
                waitTick()
        end

        function botTools.sprintJumpToPoint(x,y,z)
            --function initialization
                --initialize function table
                    local FUNC = {}
                --store arguments in locally scoped table for scope safety
                    FUNC.x = x
                    FUNC.y = y
                    FUNC.z = z

            FUNC.arrivedDistance = 0.5
            FUNC.slowDownDistance = 6
            while(compTools.playerhorizontalSquareDistanceBetween(FUNC.x + 0.5, FUNC.z + 0.5) > FUNC.arrivedDistance or compTools.playerVerticalSquareDistanceBetween(FUNC.y) > 10)do
                botTools.eatIfHungery()
                -- walk twords point
                    if compTools.playerhorizontalSquareDistanceBetween(FUNC.x + 0.5, FUNC.z + 0.5) < FUNC.slowDownDistance then
                        -- walk
                            while(compTools.playerhorizontalSquareDistanceBetween(FUNC.x + 0.5, FUNC.z + 0.5) > FUNC.arrivedDistance or compTools.playerVerticalSquareDistanceBetween(FUNC.y) > 10) do
                                botTools.eatIfHungery()
                                botTools.lookTowards(FUNC.x,FUNC.z)
                                forward(-1)
                                sprint(false)
                                sleep(50)
                                jump()
                            end
                    else
                        -- run
                            while(compTools.playerhorizontalSquareDistanceBetween(FUNC.x + 0.5, FUNC.z + 0.5) > FUNC.slowDownDistance or compTools.playerVerticalSquareDistanceBetween(FUNC.y) > 10) do
                                botTools.eatIfHungery()
                                botTools.lookTowards(FUNC.x,FUNC.z)
                                forward(-1)
                                sprint(true)
                                sleep(50)
                                jump()
                            end
                    end
            end
            -- stop traveling
                forward(1)
                waitTick()
        end

    function botTools.disconnectIfAfkForTenSeconds()
        --function initialization
                --initialize function table
                    local FUNC = {}
        -- stop moving
            botTools.freezeAllMotorFunctions()
            -- give time for moving player to stop moving
            sleep(500)

        -- Attempt to use "/logout" for combat-timer enabled servers
            say("/logout")

        FUNC.startX, FUNC.startY, FUNC.startZ = getPlayerPos()

        -- floor coordinates
            FUNC.startX = math.floor(FUNC.startX)
            FUNC.startY = math.floor(FUNC.startY)
            FUNC.startZ = math.floor(FUNC.startZ)


        FUNC.i = 10
        while FUNC.i > 0 do
            FUNC.pX, FUNC.pY, FUNC.pZ = getPlayerPos()
            -- floor coordinates
                FUNC.pX = math.floor(FUNC.pX)
                FUNC.pY = math.floor(FUNC.pY)
                FUNC.pZ = math.floor(FUNC.pZ)
            if FUNC.pX==FUNC.startX and FUNC.pY==FUNC.startY and FUNC.pZ==FUNC.startZ then
                log("logging out if no player movement in: ".. FUNC.i)
                sleep(1000)
            else
                break
            end

            -- keep at end of loop
                FUNC.i = FUNC.i - 1
        end

        if FUNC.i == 0 then
            disconnect()
        else
            log("disconnect canceled...")
        end
    end

    function botTools.dropAllOfItemExcept(sitem,stacksToKeep)
        -- function initialization
            -- declare table to hold all FUNC scoped variables in
                local FUNC = {}
            --store arguments in locally scoped table for scope safety
                FUNC.sitem = sitem
                FUNC.stacksToKeep = stacksToKeep or 0

        --get inventory
            FUNC.inv = openInventory()
            FUNC.map = FUNC.inv.mapping.inventory
        --count items in inventory
            FUNC.numItem = 0
            --count FUNC.sitem in hotbar
                for i,j in pairs(FUNC.map.hotbar) do
                    -- store args in scope-safe table
                        FUNC.j = j
                    FUNC.item = FUNC.inv.getSlot(FUNC.j)
                    if FUNC.item and FUNC.item.id==FUNC.sitem then
                        FUNC.numItem = FUNC.numItem + 1
                    end
                end
            -- count FUNC.sitem in inventory     
                for i,j in pairs(FUNC.map.main) do
                    -- store args in scope-safe table
                        FUNC.j = j
                    FUNC.item = FUNC.inv.getSlot(FUNC.j)
        
                    if FUNC.item and (FUNC.item.id==FUNC.sitem) then
                        FUNC.numItem = FUNC.numItem + 1
                    end
                end

        --drop all but "stacksToKeep" stacks of sitem
            while FUNC.numItem > FUNC.stacksToKeep do
                botTools.summonItem(FUNC.sitem, FUNC.workSlot)
                    sleep(100)
                    drop(true)
                    sleep(100)

                --keep at end of while
                    FUNC.numItem = FUNC.numItem - 1
            end
    end

return botTools