import { OPAClient } from '@styra/opa'
import fetchData from './fetch-data'

// hydrate comments based on an array of item ids
export default async function fetch(ids) {
  const sdk = new OPAClient('http://127.0.0.1:8181')
  return fetchIDs(ids, sdk)
}

async function fetchIDs(ids, sdk) {
  const rawComments = await Promise.all(
    ids.map(async (id) => {
      const val = await fetchData(`item/${id}`)
      return {
        id: val.id,
        user: val.by,
        text: val.text,
        date: new Date(val.time * 1000).getTime() || 0,
        comments: await fetchIDs(val.kids || [], sdk),
        commentsCount: val.descendants || 0
      }
    })
  )
  const inputs = Object.fromEntries(rawComments.map((c) => [c.id, c]))
  return sdk
    .evaluateBatch('process/comment/output', inputs, {
      rejectMixed: true,
      fallback: true
    })
    .then((res) => Object.values(res))
}
