<script context="module">
  import { supabase } from '$lib/db';
  export const load = async () => {
    // prettier-ignore
    const { data: contacts, error } = await supabase
      .from('contacts')
      .select()

    if (error) {
      console.log(error);
      return {};
    }

    return {
      props: { contacts },
    };
  };
</script>

<script>
  export let contacts;
</script>

<h1>About us</h1>
<p>
  Asia Pacific University Indonesian Student Society is an international student society, formed
  back in 2005. Initially we were created by our seniors to provide Indonesians student a platform
  to celebrate our own Independence Day and obviously, to also strengthen fellow Indonesians in APU
  bonds. We proudly stand as one of the biggest and most active society in our campus with our
  varieties of event and activities. Not so similar with other common student societies out there,
  we decided to create and grow our community in family-like environment, thus encourage members
  growth not only in organizational aspect, but also in their own talent and interest. Currently we
  have 7 active clubs specializing in various types of sport and art.
</p>

<br />

<p>
  Aside from our weekly clubs' activities, we also have our own annually event for both internal and
  external. From charity to cultural show, we got them all. We envision to create event not only to
  entertain, but also educating and benefiting the societies in various way. And that’s how we able
  snatch the award of most active international community and the award of charity &amp community in
  2018.
</p>

<h1 style="margin-top: 1.5rem">Contact</h1>

{#each contacts as c}
  <h4>{c.service}: {c.value}</h4>
{/each}

<style>
  h1,
  h4 {
    margin-bottom: 1.5rem;
  }
  p {
    text-indent: 2rem;
  }
</style>
