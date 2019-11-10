import { Controller } from 'stimulus'
import BrowsedPlaces from '../models/browsed_places'

export default class extends Controller {
  static targets = ['container']

  async connect() {
    const browsedPlaces = new BrowsedPlaces(this.limit, this.withoutPlaceId)
    this.containerTarget.innerHTML = await browsedPlaces.listViewHtml()
  }

  get limit() { return this.data.get('limit') }

  get withoutPlaceId() { return this.data.get('without_place_id') }
}
