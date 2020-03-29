// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

require("jquery")
require("popper.js")
require("bootstrap")

// console.log('hogehoge')

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
// import 'babel-polyfill'
import Vue from 'vue'
import Vuex from 'vuex'
import VueRouter from 'vue-router';
import App from '../app.vue'
// import store from './store.js'
import router from './router'

Vue.use(Vuex)
Vue.use(VueRouter)

Vue.config.productionTip = false

document.addEventListener('DOMContentLoaded', () => {
  new Vue({
    el: '#app',
    // store: store,
    router,
    render: (h) => h(App)
  })
})

document.addEventListener('turbolinks:load', function() {
  document.querySelectorAll('td').forEach(function(td) {
    td.addEventListener('mouseover', function(e) {
      e.currentTarget.style.backgroundColor = '#eff';
    })
    td.addEventListener('mouseout', function(e) {
      e.currentTarget.style.backgroundColor = '';
    })
  })

  document.querySelectorAll('.delete').forEach(function(a) {
    a.addEventListener('ajax:success', function() {
      var td = a.parentNode;
      var tr = td.parentNode;
      tr.style.display = 'none';
    })
  })
})