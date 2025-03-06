<script lang="ts">
  import { onMount } from "svelte";

  let onlineCount = 12;
  let offlineCount = 5;
  let lastUpdated = "ขณะนี้";
  let searchTerm = "";
  let filteredData = [];
  let currentData = [];
  let summary = [];

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

  const getEmojiByLastUpdated = (timestamp) => {
    const now = new Date();
    const updatedTime = new Date(timestamp);
    const diffInMinutes = Math.floor((now - updatedTime) / 60000);
    return diffInMinutes <= 10 ? "🟢" : "🔴";
  };

  const updateSummary = () => {
    onlineCount = currentData.filter(
      (item) => getEmojiByLastUpdated(item.updatedAt) === "🟢"
    ).length;
    offlineCount = currentData.length - onlineCount;
    lastUpdated = new Date().toLocaleTimeString("th-TH");
  };

  $: {
    if (searchTerm) {
      currentData = currentData.filter((item) =>
        Object.values(item).some((value) =>
          String(value).toLowerCase().includes(searchTerm.toLowerCase())
        )
      );
    } else {
      currentData = currentData;
    }
  }

  function getscript() {
  const text = `
    getgenv().time_m = 10

    loadstring(game:HttpGet("https://raw.githubusercontent.com/MAMMOZ/Bussy-web/refs/heads/main/script.lua"))()
  `;

  if (navigator.clipboard && navigator.clipboard.writeText) {
    navigator.clipboard
      .writeText(text)
      .then(() => console.log("ข้อความถูกคัดลอกไปยังคลิปบอร์ดแล้ว!"))
      .catch((err) => console.error("ไม่สามารถคัดลอกข้อความได้: ", err));
  } else {
    // Fallback method
    const textarea = document.createElement("textarea");
    textarea.value = text;
    document.body.appendChild(textarea);
    textarea.select();
    try {
      document.execCommand("copy");
      console.log("ข้อความถูกคัดลอกไปยังคลิปบอร์ดแล้ว!");
    } catch (err) {
      console.error("ไม่สามารถคัดลอกข้อความได้: ", err);
    }
    document.body.removeChild(textarea);
  }
}


  async function deleall() {
    try {
      const response = await fetch(`http://110.164.203.137:3000/deleall`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
      });
      const newData = await response.json();
      console.log(newData);
      
    } catch (error) {
      console.error("Error fetching data:", error);
    }
  }

  async function fetchBotData() {
    try {
      const response = await fetch(`http://110.164.203.137:3000/bot`, {
        method: "POST", // ใช้ POST method
        headers: {
          "Content-Type": "application/json", // ระบุว่า body เป็น JSON
        },
      });
      const newData = await response.json();
      currentData = newData.data;
      summary = newData.summary;
      updateSummary();
    } catch (error) {
      console.error("Error fetching data:", error);
    }
  }

  onMount(() => {
    // updateSummary();
    fetchBotData();
    // เรียกใช้ fetchBotData ทุกๆ 10 วินาที
    const intervalId = setInterval(() => {
      fetchBotData();
    }, 10000); // ทุกๆ 10 วินาที

    // ทำความสะอาด interval เมื่อ component ถูกทำลาย
    return () => clearInterval(intervalId);
  });
</script>

<div class="text-gray-200 min-h-screen p-8 bg-[#1a1a01]">
  <!-- Stats Section -->
  <div class="grid grid-cols-2 gap-4 mb-8 sm:grid-cols-3 md:grid-cols-6">
    <div class="bg-[#222213] p-6 rounded-xl border border-yellow-500/20 shadow-lg">
      <h3 class="text-white mb-2">Online</h3>
      <p class="text-white text-4xl font-bold">{onlineCount}</p>
      <p class="text-white">Accounts</p>
    </div>
    <div class="bg-[#222213] p-6 rounded-xl border border-yellow-500/20 shadow-lg">
      <h3 class="text-white mb-2">Offline</h3>
      <p class="text-white text-4xl font-bold">{offlineCount}</p>
      <p class="text-white">Accounts</p>
    </div>
    <div class="bg-[#222213] p-6 rounded-xl border border-yellow-500/20 shadow-lg">
      <div class="flex justify-between mx-auto">
        <h3 class="text-white mb-2">Gems</h3>
        <img class="w-10" src="https://db.biggames.io/submenu/economy.png?game=ps99" alt="" srcset="">
      </div>
      <p class="text-white text-4xl font-bold">{summary.total_gem}</p>
      <p class="text-white">Pure</p>
    </div>
    <div class="bg-[#222213] p-6 rounded-xl border border-yellow-500/20 shadow-lg">
      <div class="flex justify-between mx-auto">
        <h3 class="text-white mb-2">Huge</h3>
        <img class="w-10" src="https://db.biggames.io/submenu/pets.png?game=ps99" alt="" srcset="">
      </div>
      <p class="text-white text-4xl font-bold">{summary.total_huge}</p>
      <p class="text-white">Each</p>
    </div>
    <div class="bg-[#222213] p-6 rounded-xl border border-yellow-500/20 shadow-lg">
      <div class="flex justify-between mx-auto">
        <h3 class="text-white mb-2">RAP</h3>
        <img class="w-10" src="https://db.biggames.io/logo.svg?game=ps99" alt="" srcset="">
      </div>
      <p class="text-white text-4xl font-bold">{summary.rap}</p>
      <p class="text-white">Gem</p>
    </div>
    <div class="bg-[#222213] p-6 rounded-xl border border-yellow-500/20 shadow-lg">
      <div class="flex justify-between mx-auto">
        <h3 class="text-white mb-2">Egg</h3>
        <img class="sm:w-auto w-9 h-10" src="https://db.biggames.io/_next/image?url=https%3A%2F%2Fbiggamesapi.io%2Fimage%2F17846766229&w=128&q=75" alt="" srcset="">
      </div>
      <p class="text-white text-4xl font-bold">{summary.total_egg}</p>
      <p class="text-white">Each</p>
    </div>
  </div>



  <div class="grid grid-cols-2 gap-2 mb-8 sm:grid-cols-3 md:grid-cols-6">
    <div class="bg-[#222213] p-6 rounded-xl">
      <p class="text-sm font-bold flex items-center ">
        <span class="text-white px-3" id="last-updated-serven"
          >Shiny RB : {summary.Shiny_RB}</span
        >
      </p>
    </div>
    <div class="bg-[#222213] p-6 rounded-xl">
      <p class="text-sm font-bold flex items-center">
        <span class="text-white px-3" id="last-updated-god"
          >Shiny G : {summary.Shiny_G}</span
        >
      </p>
    </div>
    <div class="bg-[#222213]  p-6 rounded-xl">
      <p class="text-sm font-bold flex items-center">
        <span class="text-white px-3" id="last-updated-cdk"
          >Shiny : {summary.Shiny}</span
        >
      </p>
    </div>
    <div class="bg-[#222213] p-6 rounded-xl">
      <p class="text-sm font-bold flex items-center">
        <span class="text-white px-3" id="last-updated-sa"
          >Rainbow : {summary.Rainbow}</span
        >
      </p>
    </div>
    <div class="bg-[#222213] p-6 rounded-xl">
      <p class="text-sm font-bold flex items-center">
        <span class="text-white px-3" id="last-updated-mirror"
          >Golden : {summary.Golden}</span
        >
      </p>
    </div>
    <div class="bg-[#222213] p-6 rounded-xl">
      <p class="text-sm font-bold flex items-center">
        <span class="text-white px-3" id="last-updated-mirror"
          >Normal : {summary.Normal}</span
        >
      </p>
    </div>
  </div>

  <div class="p-6">
    <div class="flex justify-end items-center">
      <span class="isolate inline-flex rounded-md shadow-sm">
        <button
          type="button"
          class="relative inline-flex items-center rounded-l-md text-white bg-yellow-800 px-3 py-2 text-sm font-semibold ring-1 ring-inset ring-yellow-300 focus-visible:outline hover:bg-yellow-500 focus-visible:outline-offset-2 focus-visible:outline-yellow-800"
          >⚙️Setting</button
        >
        <button
          type="button"
          on:click={deleall}
          class="relative -ml-px inline-flex items-center text-white bg-yellow-800 px-3 py-2 text-sm font-semibold ring-1 ring-inset ring-yellow-300 focus-visible:outline hover:bg-yellow-500 focus-visible:outline-offset-2 focus-visible:outline-yellow-800"
          >DeleAll</button
        >
        <button
          type="button"
          on:click={getscript}
          class="relative -ml-px inline-flex items-center rounded-r-md text-white bg-yellow-800 px-3 py-2 text-sm font-semibold ring-1 ring-inset ring-yellow-300 focus-visible:outline hover:bg-yellow-500 focus-visible:outline-offset-2 focus-visible:outline-yellow-800"
          >🎮Script</button
        >
      </span>
    </div>
  </div>

  <!-- Account Data Section -->
  <div class="bg-[#222213] rounded-xl p-6 border border-yellow-500/20 shadow-lg">
    <div class="flex justify-between items-center mb-6">
      <h2 class="text-2xl font-bold text-yellow-400">Account Data</h2>
      <div class="bg-[#505008] px-4 py-2 rounded-lg text-yellow-400">
        Last updated: {lastUpdated}
      </div>
    </div>

    <!-- Search Bar -->
    <div class="relative mb-6">
      <input
        type="text"
        id="searchInput"
        placeholder="Search"
        bind:value={searchTerm}
        class="w-full bg-[#292906] backdrop-blur-sm rounded-xl py-2 px-4 pl-10 text-yellow-300 placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-yellow-500 border border-yellow-500/30"
      />
      <svg
        class="w-5 h-5 absolute left-3 top-2.5 text-yellow-500"
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
          <tr class="text-left border-b-2 border-yellow-500/50">
            <th class="py-2 px-4 text-yellow-400">Status</th>
            <th class="py-2 px-4 text-yellow-400">Account</th>
            <th class="py-2 px-4 text-yellow-400">Rank</th>
            <th class="py-2 px-4 text-yellow-400">Rebirth</th>
            <th class="py-2 px-4 text-yellow-400">Gems</th>
            <th class="py-2 px-4 text-yellow-400">Huge</th>
            <th class="py-2 px-4 text-yellow-400">Egg</th>
            <th class="py-2 px-4 text-yellow-400">Updated At</th>
            <th class="py-2 px-4 text-yellow-400">Delete</th>
          </tr>
        </thead>
        <tbody>
          {#each currentData as item}
            <tr class="border-t border-yellow-500/20 hover:bg-yellow-800">
              <td class="py-2 px-4">{getEmojiByLastUpdated(item.updatedAt)}</td>
              <td class="py-2 px-4 font-medium text-yellow-300">{item.account}</td>
              <td class="py-2 px-4 text-yellow-300">{item.rank}</td>
              <td class="py-2 px-4 text-yellow-300">{item.Rebirth}</td>
              <td class="py-2 px-4 text-yellow-300">{item.gem}</td>
              <td class="py-2 px-4 text-yellow-300">{item.huge_type}</td>
              <td class="py-2 px-4 text-yellow-300">{item.egg}</td>
              <td class="py-2 px-4 text-yellow-200">{timeAgo(item.updatedAt)}</td>
              <td class="py-2 px-4 text-yellow-200"><button type="button" class="rounded-md bg-yellow-600 px-3.5 py-2 text-sm font-semibold text-white shadow-sm hover:bg-yellow-500 focus-visible:outline-offset-2 focus-visible:outline-yellow-600">Del</button></td>
            </tr>
          {/each}
        </tbody>
      </table>
    </div>
  </div>
</div>