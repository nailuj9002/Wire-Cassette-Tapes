# Wire Cassette Tapes
An addon for Garry's Mod and [Wiremod](https://github.com/wiremod/wire) that adds a new entity that can be used to efficiently store 15 megabytes of storage in the game, on the server.
# How it works
A cassette entity is designed to hold 15728640 bytes (`WIRE_CASETTE_TOTAL_CAPACITY`) of data in chunks of 4096 bytes (`WIRE_CASETTE_CHUNK_SIZE`) stored as strings. Thus, a cassette holds a sequential table of 3840 strings.
The decision to use strings instead of Lua number tables was made specifically because a string of 4096 characters holds exactly 4096 bytes + some minor overhead (e.g. 8 bytes of pointer or whatever), while a Lua table of numbers would take up eight times the space intended.
Still, in-game, the interfaces convert reader's buffer to a table of 4096 Lua numbers, which, while not perfectly efficient, is still better than holding 15728640 Lua numbers.
# How to use it in game
Wire Cassette Tape and Wire Cassette Reader entities are available in Q-menu Wire tool tab in category 'Memory'.<br>
Wire Cassette Reader has a buffer of 4096 bytes (actually, these are Lua numbers, but only values 0 to 255 may be used in it as they will get flattened to a string of 4096 characters). It is accessible via the Hi-Speed interface.<br>
Wire Cassette Reader has Wire inputs to Read, Write, Advance and Rewind the tape.<br>
- When Read is triggered (at all; you can write the same number to it as it already has and it will trigger), current sector of the tape will be copied onto the reader's buffer.
- When Write is triggered, reader's buffer will be copied onto the current sector of the tape
- When Advance is triggered, Cassette's tape will be moved one sector forward.
- When Rewind is triggered, Cassette's tape will be moved one sector backward.
- When Eject is triggered, Cassette will be ejected from the reader. You can also manually eject the cassette by pressing USE on it.
# Shameless Plug
This addon has been created for my spacebuild* server **Space Sandbox Server**. Feel free to join our Discord for collection and IP.<br>
https://discord.com/invite/QgWpfpw9F6
# Credits
Cassette model is this: https://sketchfab.com/3d-models/cassette-tapes-820777808625494581401700ccc3e7f7
Cassette reader model is this: https://sketchfab.com/3d-models/cassette-player-57f556902cf940699103696f1d95a19b
Interestingly enough, it appears that these links are actually reposts of the original model that seems to has been removed since. If you're the original author of these models please reach out to me on our discord.
