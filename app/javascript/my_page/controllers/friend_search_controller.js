import SearchedUser from "../models/searched_user"

import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "keyword", "container" ]

  async search() {
    const data = new FormData();
    data.append("keyword", this.keywordTarget.value)
    const request = new Request("/api/user-search", {
      method: "POST",
      body: data
    })

    const response = await fetch(request)
    const users = await response.json()
    this.containerTarget.setAttribute("aria-disabled", false)
    users.forEach(user => {
      const searched_user = new SearchedUser(user.id, user.name)
      this.containerTarget.innerHTML += searched_user.html
    })
  }

  close() {
    this.containerTarget.setAttribute('aria-disabled', true)
  }
}
