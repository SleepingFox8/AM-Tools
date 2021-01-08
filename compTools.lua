--initialization
    -- import dependencies
        local compTools = { _version = "1.0.0" }
    
    --initialize GLBL table if needed
        if GLBL == nil then
            GLBL = {}
        end

--function declarations
    -- thread related
        function compTools.anotherInstanceOfThisScriptIsRunning()
            -- function initialization
                local FUNC = {}

            FUNC.threads = thread.listRunning()
            for key,value in pairs(FUNC.threads) do 
                -- put arguments in scope safe table
                    FUNC.key,FUNC.value = key,value

                if FUNC.threads[FUNC.key].getLabel() == thread.current().getLabel() and FUNC.threads[FUNC.key].getID() ~= thread.current().getID() then
                    return true
                end
            end
            return false
        end

        function compTools.stopOtherInstancesOfThisScript()
            -- function initialization
                local FUNC = {}

            FUNC.currentLabel = thread.current().getLabel()
            FUNC.threads = thread.listRunning()

            log("&7[&bNOTICE&7]&b The &fWHITE&b errors BELOW are intentionally software induced and not a sign of a problem.")

            -- stop all identical script instances that arent this one
            -- thread killing is asynchronous
                for key,value in pairs(FUNC.threads) do
                    -- store args in scope-safe table
                        FUNC.key,FUNC.value = key,value

                    if FUNC.threads[FUNC.key].getLabel() == FUNC.currentLabel and FUNC.threads[FUNC.key].getID() ~= thread.current().getID() then
                        -- pause thread
                            FUNC.threads[FUNC.key].pause()
                            sleep(10)
                        -- stop thread
                            FUNC.threads[FUNC.key].stop()
                    end
                end
            -- give time for asynchronous thread killing to happen
            -- turns this function into a (hopefully always) synchronous one
                sleep(10)

            log("&7[&bNOTICE&7]&b The &fWHITE&b errors ABOVE are intentionally software induced and not a sign of a problem.")
        end

        function compTools.stopAllInstancesOfThisScript()
            stopOtherInstancesOfThisScript()
            -- stop this script
                thread.current().stop()
        end

        function compTools.givenScriptIsRunning(scriptLabel)
            --function initialization
                --initialize function table
                    local FUNC = {}
                --store arguments in locally scoped table for scope safety
                    FUNC.scriptLabel = scriptLabel

            FUNC.threads = thread.listRunning()
            for key,value in pairs(FUNC.threads) do 
                -- put arguments in scope safe table
                    FUNC.key,FUNC.value = key,value

                if FUNC.threads[FUNC.key].getLabel() == FUNC.scriptLabel then
                    return true
                end
            end
            return false
        end

    function compTools.Bresenham3D(x1,y1,z1,x2,y2,z2)
        --function initialization
            --initialize function table
                local FUNC = {}
            --store arguments in locally scoped table for scope safety
                FUNC.x1 = x1
                FUNC.y1 = y1
                FUNC.z1 = z1

                FUNC.x2 = x2
                FUNC.y2 = y2
                FUNC.z2 = z2

        FUNC.listOfPoints = {}
        FUNC.listOfPoints[1] = {FUNC.x1,FUNC.y1,FUNC.z1}
        FUNC.dx = math.abs(FUNC.x2 - FUNC.x1)
        FUNC.dy = math.abs(FUNC.y2 - FUNC.y1)
        FUNC.dz = math.abs(FUNC.z2 - FUNC.z1)

        --declare local variables that can't be assigned yet
            FUNC.xs = 0
            FUNC.ys = 0
            FUNC.zs = 0

        if (FUNC.x2 > FUNC.x1) then
            FUNC.xs = 1
        else
            FUNC.xs = -1
        end

        if (FUNC.y2 > FUNC.y1) then 
            FUNC.ys = 1
        else
            FUNC.ys = -1
        end

        if (FUNC.z2 > FUNC.z1) then
            FUNC.zs = 1
        else
            FUNC.zs = -1
        end

        -- Driving axis is X-axis
        if (FUNC.dx >= FUNC.dy and FUNC.dx >= FUNC.dz) then
            FUNC.p1 = 2 * FUNC.dy - FUNC.dx 
            FUNC.p2 = 2 * FUNC.dz - FUNC.dx 
            while (FUNC.x1 ~= FUNC.x2) do 
                FUNC.x1 = FUNC.x1 + FUNC.xs
                if (FUNC.p1 >= 0) then
                    FUNC.y1 = FUNC.y1 + FUNC.ys 
                    FUNC.p1 = FUNC.p1 - (2 * FUNC.dx)
                end

                if (FUNC.p2 >= 0) then
                    FUNC.z1 = FUNC.z1 + FUNC.zs 
                    FUNC.p2 = FUNC.p2 - (2 * FUNC.dx)
                end

                FUNC.p1 = FUNC.p1 + (2 * FUNC.dy)
                FUNC.p2 = FUNC.p2 + (2 * FUNC.dz)
                -- FUNC.listOfPoints.append((FUNC.x1, FUNC.y1, FUNC.z1)) 
                    FUNC.listOfPoints[#FUNC.listOfPoints + 1] = {FUNC.x1,FUNC.y1,FUNC.z1}
            end
        
        -- Driving axis is Y-axis
        elseif (FUNC.dy >= FUNC.dx and FUNC.dy >= FUNC.dz) then
            FUNC.p1 = 2 * FUNC.dx - FUNC.dy 
            FUNC.p2 = 2 * FUNC.dz - FUNC.dy
            while (FUNC.y1 ~= FUNC.y2) do
                FUNC.y1 = FUNC.y1 + FUNC.ys
                if (FUNC.p1 >= 0) then
                    FUNC.x1 = FUNC.x1 + FUNC.xs 
                    FUNC.p1 = FUNC.p1 - (2 * FUNC.dy)
                end
                if (FUNC.p2 >= 0) then
                    FUNC.z1 = FUNC.z1 + FUNC.zs 
                    FUNC.p2 = FUNC.p2 - (2 * FUNC.dy)
                end
            FUNC.p1 = FUNC.p1 + (2 * FUNC.dx)
            FUNC.p2 = FUNC.p2 + (2 * FUNC.dz)
            -- FUNC.listOfPoints.append((FUNC.x1, FUNC.y1, FUNC.z1)) 
                FUNC.listOfPoints[#FUNC.listOfPoints + 1] = {FUNC.x1,FUNC.y1,FUNC.z1}
            end

        -- Driving axis is Z-axis"
        else
            FUNC.p1 = 2 * FUNC.dy - FUNC.dz 
            FUNC.p2 = 2 * FUNC.dx - FUNC.dz 
            while (FUNC.z1 ~= FUNC.z2) do
                FUNC.z1 = FUNC.z1 + FUNC.zs 
                if (FUNC.p1 >= 0) then
                    FUNC.y1 = FUNC.y1 + FUNC.ys 
                    FUNC.p1 = FUNC.p1 - (2 * FUNC.dz)
                end
                if (FUNC.p2 >= 0) then
                    FUNC.x1 = FUNC.x1 + FUNC.xs 
                    FUNC.p2 = FUNC.p2 - (2 * FUNC.dz)
                end
                FUNC.p1 = FUNC.p1 + (2 * FUNC.dy)
                FUNC.p2 = FUNC.p2 + (2 * FUNC.dx)
                --     FUNC.listOfPoints.append((FUNC.x1, FUNC.y1, FUNC.z1))  
                    FUNC.listOfPoints[#FUNC.listOfPoints + 1] = {FUNC.x1,FUNC.y1,FUNC.z1}
            end        
        end
        return FUNC.listOfPoints
    end

    function compTools.numOfKeysInTable(table)
        --function initialization
            --initialize function table
                local FUNC = {}
            --store arguments in locally scoped table for scope safety
                FUNC.table = table
            
        FUNC.numKeys = 0
        for key,value in pairs(FUNC.table) do 
            FUNC.numKeys = FUNC.numKeys + 1
        end

        return FUNC.numKeys
    end

    function compTools.tableIsEmpty(table)
        return next(table) == nil
    end

    function compTools.spairs(t, order)
        --initialize function table
            local FUNC = {}

        -- collect the keys
            FUNC.keys = {}
            for k in pairs(t) do 
                FUNC.keys[#FUNC.keys+1] = k 
            end
    
        -- if order function given, sort by it by passing the table and keys a, b,
        -- otherwise just sort the keys 
        if order then
            table.sort(FUNC.keys, function(a,b) return order(t, a, b) end)
        else
            table.sort(FUNC.keys)
        end
    
        -- return the iterator function
        FUNC.i = 0
        return function()
            FUNC.i = FUNC.i + 1
            if FUNC.keys[FUNC.i] then
                return FUNC.keys[FUNC.i], t[FUNC.keys[FUNC.i]]
            end
        end
    end

    function compTools.readAll(file)
        --function initialization
            --initialize function table
                local FUNC = {}
            --store arguments in locally scoped table for scope safety
                FUNC.file = file

        FUNC.f = assert(io.open("../"..FUNC.file, "rb"))
        FUNC.content = FUNC.f:read("*all")
        FUNC.f:close()
        return FUNC.content
    end

    function compTools.sortTableByKeys(table)
        --function initialization
            --initialize function table
                local FUNC = {}
            --store arguments in locally scoped table for scope safety
                FUNC.table = table

        FUNC.sortedTable = {}
        for k,v in compTools.spairs(FUNC.table) do
            FUNC.sortedTable[#FUNC.sortedTable + 1] = k
        end
        return FUNC.sortedTable
    end

    --reverses the order of tables with numerical indexes
    function compTools.reverse(arr)
        --function initialization
            --initialize function table
                local FUNC = {}
            --store arguments in locally scoped table for scope safety
                FUNC.arr = arr

        FUNC.i, FUNC.j = 1, #FUNC.arr

        while FUNC.i < FUNC.j do
            FUNC.arr[FUNC.i], FUNC.arr[FUNC.j] = FUNC.arr[FUNC.j], FUNC.arr[FUNC.i]

            FUNC.i = FUNC.i + 1
            FUNC.j = FUNC.j - 1
        end
    end

    function compTools.distanceBetweenPoints(tX,tY,tZ, pX,pY,pZ)
        --function initialization
            --initialize function table
                local FUNC = {}
            --store arguments in locally scoped table for scope safety
                FUNC.tX,FUNC.tY,FUNC.tZ = tX,tY,tZ
                FUNC.pX,FUNC.pY,FUNC.pZ = pX,pY,pZ

        return ((FUNC.tX - FUNC.pX)^2 + (FUNC.tY - FUNC.pY)^2 + (FUNC.tZ - FUNC.pZ)^2)^(1/2)
    end

    function compTools.playerDistanceFrom(tX,tY,tZ)
        --function initialization
            --initialize function table
                local FUNC = {}
            --store arguments in locally scoped table for scope safety
                FUNC.tX = tX
                FUNC.tY = tY
                FUNC.tZ = tZ

        FUNC.pX, FUNC.pY, FUNC.pZ = getPlayerPos()
        -- target center of block
            FUNC.tX = tX + 0.5
            FUNC.tY = tY + 0.5
            FUNC.tZ = tZ + 0.5
        return compTools.distanceBetweenPoints(FUNC.tX,FUNC.tY,FUNC.tZ, FUNC.pX,FUNC.pY,FUNC.pZ)
    end

    function compTools.horizontalSquareDistanceBetween(x1,z1, x2,z2)
        --function initialization
            --initialize function table
                local FUNC = {}
            --store arguments in locally scoped table for scope safety
                FUNC.x1 = x1
                FUNC.z1 = z1
                FUNC.x2 = x2
                FUNC.z2 = z2

        --calculate horizontal differences
            FUNC.xDist = math.abs(FUNC.x1 - FUNC.x2)
            FUNC.zDist = math.abs(FUNC.z1 - FUNC.z2)

        --find greatest horizontal distance
            if FUNC.xDist >= FUNC.zDist then
                return FUNC.xDist
            else
                return FUNC.zDist
            end
    end

    function compTools.verticalSquareDistanceBetween(y1, y2)
        --function initialization
            --initialize function table
                local FUNC = {}
            --store arguments in locally scoped table for scope safety
                FUNC.y1 = y1
                FUNC.y2 = y2

        return math.abs(FUNC.y1 - FUNC.y2)
    end

    function compTools.playerhorizontalSquareDistanceBetween(x,z)
        --function initialization
            --initialize function table
                local FUNC = {}
            --store arguments in locally scoped table for scope safety
                FUNC.x = x
                FUNC.z = z

        --declare local variables
            --get player position
                FUNC.pX, FUNC.pY, FUNC.pZ = getPlayerPos()
        return compTools.horizontalSquareDistanceBetween(FUNC.x,FUNC.z, FUNC.pX,FUNC.pZ)
    end

    function compTools.playerVerticalSquareDistanceBetween(y)
        --function initialization
            --initialize function table
                local FUNC = {}
            --store arguments in locally scoped table for scope safety
                FUNC.y = y

        --declare local variables
            --get player position
                FUNC.pX, FUNC.pY, FUNC.pZ = getPlayerPos()
        return compTools.verticalSquareDistanceBetween(FUNC.pY, FUNC.y)
    end

    function compTools.split(inputstr, sep)
        --function initialization
            --initialize function table
                local FUNC = {}
            --store arguments in locally scoped table for scope safety
                FUNC.inputstr = inputstr
                FUNC.sep = sep

        FUNC.sep = FUNC.sep or '%s'
        FUNC.t = {}
        for field, s in string.gmatch(FUNC.inputstr, "([^" .. FUNC.sep .. "]*)(" .. FUNC.sep .. "?)") do
            --put locl variables in safe scope
                FUNC.field = field
                FUNC.s = s

            table.insert(FUNC.t, FUNC.field)
            if FUNC.s == "" then return FUNC.t end
        end
    end

return compTools