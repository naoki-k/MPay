import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "keyword", "result" ]

  search() {
    const data = new FormData();
    data.append("keyword", this.keywordTarget.value)
    const request = new Request("/user_search", {
      method: "POST",
      body: data
    })

    fetch(request).then((response) => {
      this.resultTarget.setAttribute("aria-disabled", false)
      return response.json()
    }).then((data) => {
      this.resultTarget.innerHTML = ""
      data.forEach((user) => {
        this.resultTarget.innerHTML += `
        <div>
          <a href="/users/${user[0]}"> ${user[2]} </a>
        <div>
        `
      })
    }).catch(() => {
      this.resultTarget.innerHTML = "<div>not found</div>"
    })
  }

  close() {
    this.resultTarget.setAttribute('aria-disabled', true)
  }
}
