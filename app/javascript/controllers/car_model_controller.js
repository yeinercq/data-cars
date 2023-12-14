import { Controller } from "@hotwired/stimulus"
import { get } from "@rails/request.js"

// Connects to data-controller="car-model"
export default class extends Controller {
  static targets = ["modelSelect"]
  static values = {
    url: String,
    param: String
  }

  connect() {
    console.log("Connected")
  }

  change(event) {

    let params = new URLSearchParams()

    params.append( this.paramValue, event.target.selectedOptions[0].value )
    params.append( "target", this.modelSelectTarget.id )

    get(this.urlValue + '?' + params, {
      responseKind: "turbo-stream"
    })
  }
}
