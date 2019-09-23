import Rails from 'rails-ujs'
import { Application } from 'stimulus'
import ClipboardController from '../clipboard/controllers/clipboard_controller'
import FlashController from '../flash/controllers/flash_controller'
import FriendSearchController from '../my_page/controllers/friend_search_controller'
import RelationshipsController from '../my_page/controllers/relationships_controller'
import FriendsController from '../my_page/controllers/friends_controller'
import FollowersController from '../my_page/controllers/followers_controller'
import FollowingsController from '../my_page/controllers/followings_controller'
import TabLayoutController from '../tab_layout/controllers/tab_layout_controller'

const application = Application.start()
application.register('clipboard', ClipboardController)
application.register('flash', FlashController)
application.register('friend-search', FriendSearchController)
application.register('relationships', RelationshipsController)
application.register('friends', FriendsController)
application.register('followers', FollowersController)
application.register('followings', FollowingsController)
application.register('tab-layout', TabLayoutController)
Rails.start()
