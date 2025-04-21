exports.ox_inventory:displayMetadata({
    description = 'Description',
    gender = 'Gender',
    type = 'Style'
})


RegisterCommand('giveclothing', function(source, args)
    local clothingType = args[1]
    
    if not clothingMetadata[clothingType] then
        return print('Invalid clothing type')
    end
    
    exports.ox_inventory:AddItem(source, 'clothing', 1, {
        type = clothingType
    })
end, false)