export default class SearchedUser {
  constructor(id, name) {
    this.id = id
    this.name = name
  }

  get html() {
    return `
    <li>
      <a href="/users/${this.id}"> ${this.name} </a>
    </li>
    `
  }
}
