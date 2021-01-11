import Vue from 'vue';
import Vuex from 'vuex';

import layout from './layout';
import vstore from './vstore';
Vue.use(Vuex);

export default new Vuex.Store({
  modules: {
    layout,
    vstore
  },
});
