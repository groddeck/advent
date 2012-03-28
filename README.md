# Advent Game and Game Engine

This project is meant to become a tool that can be used both to play a clone of the classic interactive fiction (IF) game, _Adventure_, AKA _ADVENT_, as well as an abstractable (eventual second project) IF game engine.

## So far...

* A loop that prints a prompt, reads a text command, parses it, and attempts to execute an interpreted command, then repeats.
* Classes representing verb-actions, world-objects to be acted on, and commands.
* A _lexicon_ is a collection of understood terms, which can mostly represent command verbs, but can also be other parts of speech, such as implicit nouns that are not defined as world-objects.
* A _world_ is a collection of world-objects representing the current game-state in terms of the existing objects and the current values of their properties.

## To run:

ruby advent.rb

## TODO:

* Create a lot more built-in objects, maybe as modules that other objects can include.
* Create a lot more built-in verbs in the lexicon and create sensible default actions for verbs and objects.
* Actually start to use some of the minimal infrastructure to create rooms and objects in the world.
* Need some player-specific state capability, such as taking objects and adding them inventory.
