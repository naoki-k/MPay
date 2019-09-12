import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["tab", "content"]

  connect() {
    console.log("hello")
  }

  switch(event) {
    const index = this.tabTargets.indexOf(event.currentTarget)
    this.contentTargets.forEach((element, i) => {
      element.setAttribute('aria-disabled', i !== index)
    })
  }

  close() {
    this.contentTargets.forEach((element) => {
      element.setAttribute('aria-disabled', true)
    })
  }
}
