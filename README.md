# Advent Game and Game Engine

This project is meant to become a tool that can be used both to play a clone of the classic interactive fiction (IF) game, _Adventure_, AKA _ADVENT_, as well as an abstractable (eventual second project) IF game engine.

## So far...

* A loop that prints a prompt, reads a text command, parses it, and attempts to execute an interpreted command.
* Classes representing verb-actions, world-objects to be acted on, and commands.
* World-object subclasses representing the player, rooms, and specific types of objects.
* Modules providing behavior for common object traits, such as being a container, movability, breakability.
* Common actions such as _look_, _take_, _move_ between rooms, _inventory_, special _exit_ command which exits the game.
* A _lexicon_ is a collection of understood terms, which can mostly represent command verbs, but can also be other parts of speech, such as implicit nouns that are not defined as world-objects.
* A _game_ is a class representing the current game-state in terms of the existing objects and the container-contents graph.
* Rooms with descriptions, exits and objects pulled from Z-Code rewrite of _Advent_.
* Compass-directions and exits with capability for obstructions.

## To run:

ruby advent.rb

## To play:

* Try typing common one or two word commands such as _look_, _look_ <object>, _take_ <object>
* And try directions: north, south, east, west, up, down.

## To create a game:

* Subclass _Game_.
* Create room objects and link them with the _exit_ function.
* Create objects and place them into rooms.

## TODO:

* Continue fleshing out the _Advent_ game world and then, as necessary...
* Create a lot more built-in objects, maybe as modules that other objects can include.
* Create a lot more built-in verbs in the lexicon and create sensible default actions for verbs and objects.
* More tests, including some transcripts of commands and expected output, making use of parameterized $stdin and $stdout.
* More robust object interaction, including lamp-light, keys and locks, etc.
* PARSER: better semantic net parsing to accept helper words (look _at_ obj instead of look obj, e.g.)
* Allow multiple synonyms for objects and multi-word noun names.
* Prompt for incomplete command info ("with what?")