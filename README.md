#Arduino BattleShips:

This project allows two Arduino devices to play battleships against each other, whilst spectators watch.

Each Arduino sends a registration signal to the server, passing its 5 boats.
Once both players have registered the server will inform them of who will go first, players
will then take it in turn to make moves.

Each time a move is made, both players and all spectators will be informed of the result.
There are three possible results of a move:

 * `hit`: The move hit a ship
 * `miss`: The move missed all ships
 * `sunk`: The move hit a ship and sunk it

When One player sinks all the ships of another a game over message will be sent from the server

Error handling isn't so great right now so just restart is something goes badly wrong.

##Setup - Server

You Need:

 * Ruby
 * [Bundler](http://bundler.io)

1. Download this repository
3. Run `bundle install`
2. Run the server by navigating to the project directory in your terminal and running: `thin start`
    * This will start the server at: `http://localhost:3000`, and open a websocket on port `2999`.
3. Open the web page before starting your Arduino in order see the game as it is played.

##Setup - Arduino
1. Download and run the [Arduino Environment](http://www.arduino.cc/en/Main/Software)
2. Open the sample Arduino file: _Arduino > Battleships.ino_ file provided
    * Some newer versions of the Arduino environment seem to dramitacally fail at opening the included file.
    If this happens just copy the content into a new Arduino sketch.
3. In the top menu use: _Sketch > Import Library > Add .ZIP Library_ to import the two provided libraries:

    * Arduino-WebSocket
    * ArduinoJson

4. Connect the ethernet shield to the Arduino and to the network
5. Plug in the Arduino USB
6. Change the `hostString[]` and `server[]` variables to match your IP address
7. Change the last four sections of the `mac[]` variable to either something random,
or the Mac address that came with your ethernet shield

8. You should now be able to upload the sketch to your Arduino.

    * Make sure you have selected the correct board and port under the Tools menu.

## Mock the Arduino
If you only have one Arduino it will be very hard for you to test your solution, I recommend using `curl`
or the chrome plugin _Simple Web Socket Client_ to send messages to the server through the web socket.

###Developer Notes
Use `sass --watch styles.scss:../styles.css` to watch for sass updates from the sass directory
