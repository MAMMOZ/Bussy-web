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

<div class="bg-[#541b1b]">
  <!-- Navigation Bar -->
  <nav class="flex justify-between p-4 items-center">
    <a
      data-sveltekit-preload-data="tap"
      href="/"
      class="text-2xl font-bold text-white"
    >
      Buszysky Pet Sim 99
    </a>
    {#if userProfileValue && userProfileValue.key}
      <button class="p-2 px-5 bg-white rounded-lg" on:click={godesktop}>
        {userProfileValue.key}
      </button>
    {:else}
      <button class="p-2 px-5 bg-white rounded-lg" on:click={gologin}> Login </button>
    {/if}
  </nav>
</div>
