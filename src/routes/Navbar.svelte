<script lang="ts">
  import { page } from "$app/stores";
  import { goto } from "$app/navigation";

  $: userProfileValue = $page.data.user;
  function gologin() {
    goto(`/login`);
  }
  function godesktop() {
    goto(`/desktop`);
  }
</script>

<div class="bg-gradient-to-r from-yellow-600 to-yellow-700 border border-yellow-500/20 shadow-lg">
  <!-- Navigation Bar -->
   <center>
    <div class="p-4">

      <a
      data-sveltekit-preload-data="tap"
      href="/"
      class="text-2xl font-bold text-white"
      >
      Pet Sim 99 Logs
    </div>
    </center>
  <!-- <nav class="flex justify-between p-4 items-center">
    <a
      data-sveltekit-preload-data="tap"
      href="/"
      class="text-2xl font-bold text-white"
    >
    Pet Sim 99 Logs
    </a>
  </nav> -->
</div>
