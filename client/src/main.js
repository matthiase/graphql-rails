/* eslint-disable no-console */

import Vue from 'vue'

import _ from 'lodash'
Vue.prototype._ = _

import Buefy from 'buefy'
import '@mdi/font/css/materialdesignicons.css'
Vue.use(Buefy)

import { ApolloClient } from 'apollo-client'
import { createHttpLink } from 'apollo-link-http'
import { ApolloLink, concat } from 'apollo-link'
import { InMemoryCache } from 'apollo-cache-inmemory'

const httpLink = createHttpLink({
  uri: process.env.SERVER_URI
})

const authenticationMiddleware = new ApolloLink((operation, forward) => {
  const token = localStorage.getItem('auth_token')
  operation.setContext({
    headers: {
      authorization: token ? `Bearer ${token}` : ''
    }
  })
  return forward(operation)
})

const apolloClient = new ApolloClient({
  link: concat(authenticationMiddleware, httpLink),
  cache: new InMemoryCache(),
  connectToDevTools: true
})

import VueApollo from 'vue-apollo'
const apolloProvider = new VueApollo({
  defaultClient: apolloClient,
  defaultOptions: {
    $loadingKey: 'loading'
  },
  errorHandler(error) {
    console.error(error)
  }
})
Vue.use(VueApollo)

import App from './App.vue'

Vue.config.productionTip = false

new Vue({
  apolloProvider,
  render: h => h(App)
}).$mount('#app')
