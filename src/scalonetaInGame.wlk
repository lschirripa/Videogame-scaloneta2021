import wollok.game.*
import messi.*
import objetosRandoms.*
import backGroundsYSounds.*

object scalonetaInGame {

	var property minVelocidad = 2500
	var property maxVelocidad = 2500
	var property enJuego = true

	method velocidadRandom() = self.minVelocidad().randomUpTo(self.maxVelocidad()).roundUp()

	method configurar() {
		game.addVisual(messi)
		game.addVisual(china)
		game.addVisual(dePaul)
		game.addVisual(kiko)
		game.addVisual(rickyFort)
		game.addVisual(antonella)
		game.addVisual(mirtaLegrand)
		game.addVisual(vida1)
		game.addVisual(vida2)
		game.addVisual(vida3)
		game.showAttributes(messi) // Debug
		teclado.configurarAcciones()
	}

	method configurarAcciones() {
		game.onTick(self.velocidadRandom(), "caeRickyFort", { rickyFort.perderAltura()})
		game.onTick(self.velocidadRandom(), "caeMirtaLegrand", { mirtaLegrand.perderAltura()})
		game.onTick(self.velocidadRandom(), "caeChina", { china.perderAltura()})
		game.onTick(self.velocidadRandom(), "caeAntonella", { antonella.perderAltura()})
		game.onTick(self.velocidadRandom(), "caeDePaul", { dePaul.perderAltura()})
		game.onTick(self.velocidadRandom(), "caeKiko", { kiko.perderAltura()})
		game.onCollideDo(rickyFort, { algo => self.atraparObjeto(rickyFort)})
		game.onCollideDo(kiko, { algo => self.atraparObjeto(kiko)})
		game.onCollideDo(dePaul, { algo => self.atraparObjeto(dePaul)})
		game.onCollideDo(antonella, { algo => self.atraparObjeto(antonella)})
		game.onCollideDo(china, { algo => self.atraparObjeto(china)})
		game.onCollideDo(mirtaLegrand, { algo => self.atraparObjeto(mirtaLegrand)})
	}

	method atraparObjeto(objeto) {
		if (messi.meChocoAlguien(objeto)) {
			objeto.choqueAMessi()
			objeto.restaurarPosition()
			self.chequearEstadoDeJuego()
		}
	}

	method chequearEstadoDeJuego() {
		if (messi.teQuedasteSinVida()) {
			self.enJuego(false)
			configuracion.perdio()
		}
		if (score.alcanzarMeta()) {
			self.enJuego(false)
			configuracion.gano()
		}
	}

}

object configuracion {

	var property etapaInicial = true
	var property etapaNivel = true
	const musicaPrincipal = game.sound("musicaFondo.mp3")

	method darInicio() {
		game.addVisual(fondoInicio)
		keyboard.enter().onPressDo{ if (self.etapaInicial()) self.sonidoArranque()
		}
	}

	method sonidoArranque() {
		self.etapaInicial(false)
		game.sound("sonidoArranque.mp3").play()
		game.schedule(3000, { self.elegirComplejidad()})
	}

	method elegirComplejidad() {
		game.addVisual(fondoNivel)
		game.removeVisual(fondoInicio)
		game.addVisual(mano) //
		keyboard.up().onPressDo{ mano.moverseA(mano.position().up(2))}
		keyboard.down().onPressDo{ mano.moverseA(mano.position().down(2))}
		keyboard.a().onPressDo{ if (self.etapaNivel()) self.elegirNivel()
		}
	}

	method elegirNivel() {
		if (self.nivelEasy()) {
			score.metaAAlcanzar(200000)
			scalonetaInGame.minVelocidad(800)
			scalonetaInGame.maxVelocidad(1500)
		}
		if (self.nivelMedium()) {
			score.metaAAlcanzar(3000)
			scalonetaInGame.minVelocidad(600)
			scalonetaInGame.maxVelocidad(1000)
		}
		if (self.nivelHard()) {
			score.metaAAlcanzar(5000)
			scalonetaInGame.minVelocidad(400)
			scalonetaInGame.maxVelocidad(800)
		}
		self.configuracionInicio()
		self.etapaNivel(false)
	}

	method nivelEasy() {
		return mano.position() == game.at(7, 6)
	}

	method nivelMedium() {
		return mano.position() == game.at(7, 4)
	}

	method nivelHard() {
		return mano.position() == game.at(7, 2)
	}

	method configuracionInicio() {
		game.addVisual(fondoBoke)
		game.removeVisual(fondoNivel)
		scalonetaInGame.configurar()
		scalonetaInGame.configurarAcciones()
		game.addVisual(score)
		game.schedule(10, { musicaPrincipal.play()})
	}

	method perdio() {
		self.terminarJuego(soundPerdio.fondoRandom(), fondoPerdio)
	}

	method perdioPorMirtha() {
		self.terminarJuego("perdisteMirta.mp3", fondoPerdioPorMirtha)
	}

	method gano() {
		self.terminarJuego("ganaste2.mp3", fondoDeGano)
	}

	method terminarJuego(musica, fondoQueFinalizara) {
		game.clear()
		musicaPrincipal.pause()
		game.addVisual(fondoQueFinalizara)
		game.schedule(12000, { game.stop()})
		game.sound(musica).play()
	}

}

object mano {

	var property position = game.at(7, 6)
	var property image = "mano.png"

	method moverseA(nuevaPosicion) {
		position = nuevaPosicion
		self.corregirPosition()
	}

	method corregirPosition() {
		position = new Position(x = 7, y = (position.y().max(2)).min(6))
	}

}

object teclado {

	method configurarAcciones() {
		keyboard.left().onPressDo{ messi.irA(messi.position().left(1))}
		keyboard.right().onPressDo{ messi.irA(messi.position().right(1))}
	}

}

// ----------------------------------------------------------
//                 PALETA Y SCORE
object paleta {

	const property verde = "00FF00FF"
	const property rojo = "FF0000FF"

}

object score {

	var property position = game.at(12, 9)
	var property score = 0
	var property metaAAlcanzar = 3000

	method text() = "Score: " + score + "  Meta: " + metaAAlcanzar

	method textColor() = paleta.verde()

	method sumarScore(cantidad) {
		score += cantidad.max(3)
	}

	method alcanzarMeta() = score >= metaAAlcanzar

}

// -------------------------------------------------------------------------
//                       VIDAS POR PANTALLA
class MessiChiquito {

	var property position = new Position(x = 0, y = 9)

	method image()

	method vidasMessi(num) {
		return messi.vidas() < num
	}

}

object vida1 inherits MessiChiquito(position = game.at(0, 9)) {

	override method image() = if (self.vidasMessi(1)) "messiCaido.png" else "messiChiquito.png"

}

object vida2 inherits MessiChiquito(position = game.at(1, 9)) {

	override method image() = if (self.vidasMessi(2)) "messiCaido.png" else "messiChiquito.png"

}

object vida3 inherits MessiChiquito(position = game.at(2, 9)) {

	override method image() = if (self.vidasMessi(3)) "messiCaido.png" else "messiChiquito.png"

}

