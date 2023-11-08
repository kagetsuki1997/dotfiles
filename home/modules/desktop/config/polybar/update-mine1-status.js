#!/usr/bin/env node

const https = require("https");
const util = require("util");

// url: https://api.ethermine.org/miner/0x00000000000000000000000000000000000000bb/dashboard
const minerAddress = "0000000000000000000000000000000000000000";
const url = util.format(
  "https://api.ethermine.org/miner/%s/dashboard",
  minerAddress
);

const toEther = (value) => {
  return value / Math.pow(10, 18);
};

const toMegaHashrate = (value) => {
  return value / Math.pow(10, 6);
};

const req = https.request(url, (res) => {
  var data = null;
  res.on("data", (chunk) => {
    data = data === null ? chunk : data + chunk;
  });

  res.on("end", () => {
    const json = JSON.parse(data)["data"]["currentStatistics"];

    const reportedHashRate = toMegaHashrate(json["reportedHashrate"]).toFixed(
      2
    );
    const currentHashrate = toMegaHashrate(json["currentHashrate"]).toFixed(2);
    const unpaid = toEther(json["unpaid"]).toFixed(5);

    const status = util.format(
      "M1: %s %s MH/s %s MH/s",
      unpaid,
      reportedHashRate,
      currentHashrate
    );
    console.log(status);
  });
});

req.on("error", (error) => {
  console.log("M1: n/a");
});

req.end();
