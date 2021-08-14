// Elm stuff (this is not working via webpack yet)
import { Elm } from "./elm.js"


// It's too finicky to push data using data tags. Instead we have
// elm alert liveView that it has initilalised which triggers liveView to send
// the current state to everyone. 
// This new elm will then listen to that and update itself after it's initia
// initialisation

const initLvteElm = (id) => {
    var app = Elm.Main.init({
        node: document.getElementById(id)
    })
    return app
}

export function mutateHooks(Hooks) {
    console.log("mutateHooks", Hooks)

    Hooks.lvte_elmContainer = {
        mounted() {
            console.log("mounted")
            console.log("data:", this.el.dataset)
            // Assumes there is a child div with same id+"-content"
            var app = initLvteElm(this.el.id + "-content")

            console.log(app)
            //Javascript <-> Elm communication
            app.ports.sendMessage.subscribe(
                (msg) => this.pushEventTo(`#${this.el.id}`, msg, {})
            )

            this.handleEvent("elm_client_intialised", 
                () => app.ports.messageReciever.send("elm_client_intialised")
            )

        }
    }
}