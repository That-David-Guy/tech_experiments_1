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
                ({event, payload}) => this.pushEventTo(`#${this.el.id}`, event, payload)
            )

            this.handleEvent("new_client_initialised", 
                // (payload) => console.log(payload)
                // (payload) => app.ports.messageReciever.send(
                //     { event_data: [{color: "blue", id: 1, size: "medium"}], 
                //       event_name: "new_client_initialised"
                //     })
                (payload) => app.ports.messageReciever.send(payload)
            )

        }
    }
}