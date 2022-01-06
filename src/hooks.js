import { supabase } from '$lib/db';
import { toExpressRequest, toExpressResponse, toSveltekitResponse } from '$lib/utils/expressify';

export const handle = async ({ request, resolve }) => {
  // convert request to express style becuz supabase
  const req = toExpressRequest(request);
  const { user } = await supabase.auth.api.getUserByCookie(req);

  request.locals.user = user || { guest: true };

  let response = await resolve(request);
  if (request.method == 'POST' && request.path === '/api/auth') {
    supabase.auth.api.setAuthCookie(request, toExpressResponse(response));
    response = toSveltekitResponse(response);
  }

  return {
    ...response,
    headers: {
      ...response.headers,
      'x-custom-header': 'what?',
    },
  };
};

export const getSession = async (request) => {
  const { user } = request.locals;
  const authenticated = user && !user.guest;
  let role = '';

  if (authenticated) {
    // prettier-ignore
    const { data } = await supabase
      .from('user_roles')
      .select()
      .eq('user_id', user.id)
      .single();

    role = data.role;
  }

  return { user, authenticated, role };
};
