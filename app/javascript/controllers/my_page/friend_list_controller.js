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
}
