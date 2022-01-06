<script context="module">
  import { supabase } from '$lib/db';
  export const load = async () => {
    // prettier-ignore
    let { data: posts, error } = await supabase
      .from('blogpost_tags_aggr')
      .select();

    if (error) return {};

    return { props: { posts } };
  };
</script>

<script>
  export let posts;
</script>

<h1>Blog</h1>
<pre>{JSON.stringify(posts, null, 2)}</pre>
