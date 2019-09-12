import Rails from 'rails-ujs'
import { Application } from 'stimulus'
import ClipboardController from '../clipboard/controllers/clipboard_controller'
import FlashController from '../flash/controllers/flash_controller'
import FriendSearchController from '../my_page/controllers/friend_search_controller'
import RelationshipsController from '../relationships/controllers/relationships_controller'
import TabLayoutController from '../tab_layout/controllers/tab_layout_controller'

const application = Application.start()
application.register('clipboard', ClipboardController)
application.register('flash', FlashController)
application.register('friend-search', FriendSearchController)
application.register('relationships', RelationshipsController)
application.register('tab-layout', TabLayoutController)
Rails.start()
