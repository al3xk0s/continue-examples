import cookieParser from "cookie-parser";
import express from "express";
import { Request, Response, NextFunction } from "express";
import { logger } from "./middleware.js";
import path from "path";
import { getName, getPage } from "./helper.js";


const app = express();

const PORT = 8080;
const STATIC_DIR = path.resolve(path.resolve(), 'static');

app.use(logger);
app.use(express.static(STATIC_DIR));
app.use(cookieParser());

app.get('/', async (req: Request, res: Response, next: NextFunction) => {
    const name = await getName();
    const avatar = 'https://i.pravatar.cc/200';
    const page = getPage(name, avatar);
    res.send(page);
});

app.listen(PORT, () => {
    console.log(`Server has been started on port ${PORT}`)
});