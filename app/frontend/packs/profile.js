/* eslint no-console: 0 */

import Vue from 'vue'
import Profile from '../components/profile.vue'

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    render: h => h(Profile)
  }).$mount()
  document.body.appendChild(app.$el)
})

