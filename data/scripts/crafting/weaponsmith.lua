Crafting.weaponsmith = {
	{
        id = 1234, -- item id
        name = "Item Name", -- item name
        level = 25, -- required level to craft
        cost = 2500, -- required gold to craft
        count = 1, -- how many will it craft
        materials = {
            -- max 6 materials
            {id = 123, count = 6},
            {id = 456, count = 1},
            {id = 789, count = 2}
        }
    }
}
