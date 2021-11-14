import http from 'k6/http';
import { sleep } from 'k6';

export const options = {
  vus: 1,
  duration: '3s',
};

export default function () {
  const url = `https://test.k6.io/?arg=${__ENV.Arg1}`;
  console.log(url);
  http.get(url);
  sleep(1);
}