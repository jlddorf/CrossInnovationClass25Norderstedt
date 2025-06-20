extends Node

enum Item {NATURE, NONE}

# Dictionary of the player id to the selected item
static var selectedItems : Dictionary[int, Item]

# Dictionary of every item and it's respective placement amount. If this includes NONE, something has gone very wrong 
static var selectedProgress: Dictionary[Item, int]
