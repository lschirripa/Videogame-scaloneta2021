import wollok.game.*
import messi.*
import objetosRandoms.*
import scalonetaInGame.*

object fondoInicio {

	var property position = game.at(0, 0)

	method image() = "fondoPrincipal.jpg"

}

object fondoNivel {

	var property position = game.at(0, 0)
	var property image = "fondoNivel.jpg"

}

object fondoBoke {

	var property position = game.at(0, 0)
	var property image = "boke.jpg"

}

object fondoPerdio {

	var property position = game.at(0, 0)
	var property image = "messiTriste.jpg"

}

object fondoPerdioPorMirtha {

	var property position = game.at(0, 0)
	var property image = "perderPorMirtha.jpg"

}

object fondoDeGano {

	var property position = game.at(0, 0)
	var property image = "ganar.jpg"

}

object soundPerdio {

	var property random = randomizer

	method fondoRandom()= if (random.randomNum()==1) "perdiste1.mp3" else  "perdiste2.mp3"

}

object randomizer {

	method randomNum() = 0.randomUpTo(2).roundUp()

}

