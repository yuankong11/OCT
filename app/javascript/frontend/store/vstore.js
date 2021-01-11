
export default {
    namespaced: true,
    state: {
        eventsTimetable: [],
        eventsCount: [],
    },
    mutations: {
        getEventsCount (state) {

        },
    },
    actions: {
        getEventsCount ({ commit }) {
            commit('getEventsCount')
        },
    },
}
