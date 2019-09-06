import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "keyword", "result", "tab", "content" ]

  search() {
    const data = new FormData();
    data.append("keyword", this.keywordTarget.value)
    const request = new Request("/user_search", {
      method: "POST",
      body: data
    })

    fetch(request).then((response) => {
      this.resultTarget.setAttribute("aria-disabled", false)
      this.contentTargets.forEach((element) => {
        element.setAttribute('aria-disabled', true)
      })
      return response.json()
    }).then((data) => {
      this.resultTarget.innerHTML = ""
      data.forEach((user) => {
        this.resultTarget.innerHTML += "<div>" + user[1] + "</div>"
      })
    }).catch(() => {
      this.resultTarget.innerHTML = "<div>not found</div>"
    })
  }

  slide(event) {
    this.resultTarget.setAttribute('aria-disabled', true)
    const index = this.tabTargets.indexOf(event.currentTarget)
    this.contentTargets.forEach((element, i) => {
      element.setAttribute('aria-disabled', i !== index)
    })
  }
}
