import express from "express";
import path from "path";
import "dotenv/config";

const { PORT } = process.env;
const app = express();

app.use("/", express.static(path.resolve(process.cwd(), "./")));

app.listen(PORT, async () => {
  const URL = `http://0.0.0.0:${PORT}/index.html`;
  console.log(`server running on: ${URL}`);
});
