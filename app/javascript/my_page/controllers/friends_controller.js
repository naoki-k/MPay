import Friend from "../models/friend"

import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "container" ]

  connect() {
    this.buildList()
  }

  reload() {
    this.containerTarget.innerHTML = ''
    this.buildList()
  }

  async users() {
    const request = new Request("/api/friends", { method: "GET" })
    const response = await fetch(request)
    return await response.json()
  }

  async buildList() {
    const users = await this.users()
    if (users && users.length > 0) {
      users.forEach(user => {
        const friend = new Friend(user.id, user.name)
        this.containerTarget.innerHTML += friend.html
      })
    }
  }
}
