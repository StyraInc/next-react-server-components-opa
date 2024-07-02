import { cache } from 'react'
import { OPAClient } from '@styra/opa'
import 'server-only'

const fetchData = cache(async (type: string) => {
  const sdk = new OPAClient('http://127.0.0.1:8181')
  const res = await fetch(
    `https://hacker-news.firebaseio.com/v0/${type}.json`,
    {
      next: {
        revalidate: 10
      }
    }
  )
  if (res.status !== 200) {
    throw new Error(`Status ${res.status}`)
  }
  console.log(`fetched ${type}`)
  const data = await res.json()

  if (type.startsWith('item/') && data)
    return sdk.evaluate('process/comment/output', data)

  return data
})

export default fetchData
