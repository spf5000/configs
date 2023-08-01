require ('globals')
require ('keybindings')
require ('lsp')
require ('treesitter')

function isNix ()
    return os.getenv ("IS_NIX") ~= nil
end

if isNix () then
    print ("NIX!")
else
    print ("Not NIX!")
end

-- require ('plugins') removed b/c it's managed by home manager
-- require ('autocomplete')

