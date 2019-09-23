import { Controller } from "stimulus"
import Flash from "../../flash/models/flash"

export default class extends Controller {
  static targets = [ "container", "followers", "followings", "friends" ]

  async follow(event) {
    const id = event.currentTarget.getAttribute("value")
    await this.fetch_and_notify(`/relationships/${id}`, 'POST', 'フォローしました')
    this.reload()
  }

  async unfollow(event) {
    const id = event.currentTarget.getAttribute("value")
    await this.fetch_and_notify(`/relationships/${id}`, 'DELETE', 'フォローを外しました')
    this.reload()
  }

  async fetch_and_notify(url, method, success_message) {
    const request = new Request(url, {
      method: method,
    })

    const response = await fetch(request)
    if(response && response.status == 200) {
      const flash = new Flash('success', success_message)
      flash.show()
    } else {
      const flash = new Flash('danger', 'エラー')
      flash.show()
    }
  }

  reload() {
    this.followingsController.reload()
    this.followersController.reload()
    this.friendsController.reload()
  }

  get followingsController() {
    return this.application.getControllerForElementAndIdentifier(this.followingsTarget, "followings")
  }

  get followersController() {
    return this.application.getControllerForElementAndIdentifier(this.followersTarget, "followers")
  }

  get friendsController() {
    return this.application.getControllerForElementAndIdentifier(this.friendsTarget, "friends")
  }
}
