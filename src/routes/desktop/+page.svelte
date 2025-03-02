<script lang="ts">
  import { onMount } from "svelte";

  let onlineCount = 12;
  let offlineCount = 5;
  let lastUpdated = "ขณะนี้";

  // Search variables
  let searchTerm = "";
  let filteredData = [];
  
  // Sample data
  let allData = [
    {
      status: "online",
      account: "Player123",
      rank: "Legend",
      rebirth: 45,
      diamon: "5.2M",
      titanic: 128,
      item: "780K",
      updatedAt: new Date(Date.now() - 15 * 60 * 1000) // 15 minutes ago
    },
    {
      status: "online",
      account: "GamerPro99",
      rank: "Master",
      rebirth: 38,
      diamon: "3.7M",
      titanic: 96,
      item: "450K",
      updatedAt: new Date(Date.now() - 45 * 60 * 1000) // 45 minutes ago
    },
    {
      status: "offline",
      account: "NinjaX",
      rank: "Elite",
      rebirth: 27,
      diamon: "2.1M",
      titanic: 62,
      item: "320K",
      updatedAt: new Date(Date.now() - 6 * 60 * 60 * 1000) // 6 hours ago
    },
    {
      status: "online",
      account: "DragonSlayer",
      rank: "Champion",
      rebirth: 52,
      diamon: "6.8M",
      titanic: 145,
      item: "890K",
      updatedAt: new Date(Date.now() - 30 * 60 * 1000) // 30 minutes ago
    },
    {
      status: "offline",
      account: "PhoenixRise",
      rank: "Veteran",
      rebirth: 33,
      diamon: "2.9M",
      titanic: 78,
      item: "510K",
      updatedAt: new Date(Date.now() - 12 * 60 * 60 * 1000) // 12 hours ago
    }
  ];
  
  let currentData = allData;
  let summary = [];

  // Function to get emoji based on updatedAt
  function getEmojiByLastUpdated(updatedAt) {
    const hoursDiff = (Date.now() - new Date(updatedAt).getTime()) / (1000 * 60 * 60);
    
    if (hoursDiff < 1) {
      return "🟢"; // Less than 1 hour
    } else if (hoursDiff < 12) {
      return "🟡"; // Less than 12 hours
    } else {
      return "🔴"; // More than 12 hours
    }
  }

  // Function to display time ago
  function timeAgo(date) {
    const seconds = Math.floor((Date.now() - new Date(date).getTime()) / 1000);
    
    if (seconds < 60) return `${seconds} วินาทีที่แล้ว`;
    
    const minutes = Math.floor(seconds / 60);
    if (minutes < 60) return `${minutes} นาทีที่แล้ว`;
    
    const hours = Math.floor(minutes / 60);
    if (hours < 24) return `${hours} ชั่วโมงที่แล้ว`;
    
    const days = Math.floor(hours / 24);
    return `${days} วันที่แล้ว`;
  }

  // Filter data when search term changes
  $: {
    if (searchTerm) {
      filteredData = allData.filter(item => 
        item.account.toLowerCase().includes(searchTerm.toLowerCase()) ||
        item.rank.toLowerCase().includes(searchTerm.toLowerCase())
      );
      currentData = filteredData;
    } else {
      currentData = allData;
    }
  }
</script>

<div class="text-gray-200 min-h-screen p-8 bg-[#271111]">
  <!-- Stats Section -->
  <div class="grid grid-cols-2 gap-4 mb-8 sm:grid-cols-6">
    <div class="bg-[#541b1b] p-6 rounded-xl">
      <h3 class="text-white mb-2">Online</h3>
      <p class="text-green-400 text-4xl font-bold">{onlineCount}</p>
      <p class="text-white">Accounts</p>
    </div>
    <div class="bg-[#541b1b] p-6 rounded-xl">
      <h3 class="text-white mb-2">Offline</h3>
      <p class="text-red-400 text-4xl font-bold">{offlineCount}</p>
      <p class="text-white">Accounts</p>
    </div>
    <div class="bg-[#541b1b] p-6 rounded-xl">
      <div class="flex justify-between mx-auto">
        <h3 class="text-white mb-2">Diamon</h3>
        <img class="w-10" src="https://db.biggames.io/submenu/economy.png?game=ps99" alt="" srcset="">
      </div>
      <p class="text-blue-400 text-4xl font-bold">20.7M</p>
      <p class="text-white">Gem</p>
    </div>
    <div class="bg-[#541b1b] p-6 rounded-xl">
      <div class="flex justify-between mx-auto">
        <h3 class="text-white mb-2">Titanic</h3>
        <img class="w-10" src="https://db.biggames.io/submenu/pets.png?game=ps99" alt="" srcset="">
      </div>
      <p class="text-green-400 text-4xl font-bold">509</p>
      <p class="text-white">Gem</p>
    </div>
    <div class="bg-[#541b1b] p-6 rounded-xl">
      <div class="flex justify-between mx-auto">
        <h3 class="text-white mb-2">Rab</h3>
        <img class="w-10" src="https://db.biggames.io/logo.svg?game=ps99" alt="" srcset="">
      </div>
      <p class="text-blue-400 text-4xl font-bold">7M</p>
      <p class="text-white">Gem</p>
    </div>
    <div class="bg-[#541b1b] p-6 rounded-xl">
      <div class="flex justify-between mx-auto">
        <h3 class="text-white mb-2">Item</h3>
        <img class="w-10" src="https://db.biggames.io/leaderboard.png?game=ps99" alt="" srcset="">
      </div>
      <p class="text-blue-400 text-4xl font-bold">1M</p>
      <p class="text-white">Gem</p>
    </div>
  </div>

  <!-- Account Data Section -->
  <div class="bg-[#541b1b] rounded-xl p-6">
    <div class="flex justify-between items-center mb-6">
      <h2 class="text-2xl font-bold text-white">Account Data</h2>
    </div>

    <!-- Search Bar -->
    <div class="relative mb-6">
      <input
        type="text"
        id="searchInput"
        placeholder="Search"
        bind:value={searchTerm}
        class="w-full bg-gray-900/30 backdrop-blur-sm rounded-xl py-2 px-4 pl-10 text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-red-500"
      />
      <svg
        class="w-5 h-5 absolute left-3 top-2.5 text-gray-400"
        fill="none"
        stroke="currentColor"
        viewBox="0 0 24 24"
      >
        <path
          stroke-linecap="round"
          stroke-linejoin="round"
          stroke-width="2"
          d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"
        />
      </svg>
    </div>

    <!-- Table -->
    <div class="overflow-x-auto">
      <table class="w-full">
        <thead>
          <tr class="text-left border-b border-red-800/50">
            <th class="py-2 px-4 text-red-200">Status</th>
            <th class="py-2 px-4 text-red-200">Account</th>
            <th class="py-2 px-4 text-red-200">Rank</th>
            <th class="py-2 px-4 text-red-200">Rebirth</th>
            <th class="py-2 px-4 text-red-200">Diamon</th>
            <th class="py-2 px-4 text-red-200">Titanic</th>
            <th class="py-2 px-4 text-red-200">Item</th>
            <th class="py-2 px-4 text-red-200">Updated At</th>
          </tr>
        </thead>
        <tbody>
          {#each currentData as item}
            <tr class="border-t border-red-800/30 hover:bg-red-900/20">
              <td class="py-2 px-4">{getEmojiByLastUpdated(item.updatedAt)}</td>
              <td class="py-2 px-4">{item.account}</td>
              <td class="py-2 px-4">{item.rank}</td>
              <td class="py-2 px-4">{item.rebirth}</td>
              <td class="py-2 px-4">{item.diamon}</td>
              <td class="py-2 px-4">{item.titanic}</td>
              <td class="py-2 px-4">{item.item}</td>
              <td class="py-2 px-4">{timeAgo(item.updatedAt)}</td>
            </tr>
          {/each}
        </tbody>
      </table>
    </div>
  </div>
</div>