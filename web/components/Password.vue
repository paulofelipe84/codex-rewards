<template>
  <v-layout>
    <v-dialog class="modal-dialog modal-dialog-centered" persistent v-model="dialog" width="500px">
      <div class="modal-content black--text">
        <div class="modal-header text-center py-2">
          <h2 class="modal-title w-100 fw-bolder">Provide the file password</h2>
          <!-- <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button> -->
        </div>
        <div class="modal-body">
          <v-text-field 
            label="Password" 
            v-model="password" 
            ref="passwordInput" 
            @keydown.enter="confirmPassword"
            :append-icon="showPassword ? 'mdi-eye' : 'mdi-eye-off'"
            :type="showPassword ? 'text' : 'password'"
            @click:append="showPassword = !showPassword"
            solo
            background-color="grey"
            autofocus
          />
        </div>
        <div class="modal-footer">
          <v-spacer/>
          <v-btn plain x-large color="blue" @click="confirmPassword">
            Confirm
          </v-btn>
          <v-spacer/>
        </div>
      </div>
    </v-dialog>
  </v-layout>
</template>

<script>
import Vue from 'vue'
export default {
  data() {
    return {
      password: '',
      showPassword: false
    }
  },
  props: ['open', 'validate', 'notEmpty'],
  computed: {
    dialog() {
      return this.open
    },
    headline() {
      return 'Enter your password'
    }
  },
  methods: {
    confirmPassword() {
      const password = this.password
      if (this.notEmpty && this.password === '') {
        alert('Password is required!')
        return false
      }
      this.$emit('password', password)
      this.password = ''
      return true
    }
  }
}
</script>
