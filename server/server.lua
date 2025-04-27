local clothingMetadata = {
    blue_jeans = {
        label = 'MaskTest',
        description = 'Mask test',
        component = 1, 
        drawable = 1,  
        texture = 0,  
        gender = 'male' 
    },
    
    red_tshirt = {
        label = 'Red T-Shirt',
        description = 'A comfortable cotton t-shirt',
        component = 8, 
        drawable = 15, 
        texture = 3,  
        gender = 'male' 
    },
    
    leather_jacket = {
        label = 'Leather Jacket',
        description = 'Classic black leather jacket',
        component = 11, 
        drawable = 12, 
        texture = 0,    
        gender = 'male'
    },
    
    blue_cap = {
        label = 'Blue Cap',
        description = 'A stylish blue cap',
        prop = 0,     
        drawable = 4,  
        texture = 2,   
        gender = 'male' 
    }
}

-- Register a hook to handle clothing item creation with specific metadata
local hookId = exports.ox_inventory:registerHook('createItem', function(payload)   
    local clothingType = payload.metadata.type
    local clothing = clothingMetadata[clothingType]
    
    if clothing then
        return clothing
    end
end, {
    itemFilter = {
        clothing = true
    }
})

