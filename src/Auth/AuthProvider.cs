using Microsoft.AspNetCore.Components.Authorization;
using Microsoft.AspNetCore.Components.Server.ProtectedBrowserStorage;
using Bloomify.Data.Models;
using System.Security.Claims;

namespace Bloomify.Auth
{
    public class AuthProvider : AuthenticationStateProvider
    {
        private readonly ProtectedSessionStorage sessionStorage;
        private readonly ClaimsPrincipal anonymous = new(new ClaimsIdentity());
        
        public AuthProvider(ProtectedSessionStorage storage)
        {
            sessionStorage = storage;
        }

        public override async Task<AuthenticationState> GetAuthenticationStateAsync()
        {
            try
            {
                var userSessionResult = await sessionStorage.GetAsync<UserSession>("UserSession");
                var userSession = userSessionResult.Success ? userSessionResult.Value : null;
                if (userSession == null)
                {
                    return await Task.FromResult(new AuthenticationState(anonymous));
                }

                var claimsPrincipal = new ClaimsPrincipal(new ClaimsIdentity(new List<Claim>
                {
                    new(ClaimTypes.Name, userSession.Nome ?? "Unknown name"),
                    new(ClaimTypes.Email, userSession.Email ?? "Unknown email"),
                    new(ClaimTypes.Role, userSession.Tipo ?? "Unknown Role")
                }, "CustomAuth"));
                return await Task.FromResult(new AuthenticationState(claimsPrincipal));
            }
            catch
            {
                return await Task.FromResult(new AuthenticationState(anonymous));
            }
        }

        public async Task UpdateAuthenticationState(UserSession? userSession)
        {
            ClaimsPrincipal claimsPrincipal;

            if (userSession != null)
            {
                await sessionStorage.SetAsync("UserSession", userSession);
                claimsPrincipal = new ClaimsPrincipal(new ClaimsIdentity(new List<Claim>
                {
                    new(ClaimTypes.Name, userSession.Nome ?? "Unknown Name"),
                    new(ClaimTypes.Email, userSession.Email ?? "Unknown Email"),
                    new(ClaimTypes.Role, userSession.Tipo ?? "Unknown Role")
                }, "CustomAuth"));
            } else
            {
                await sessionStorage.DeleteAsync("UserSession");
                claimsPrincipal = anonymous;
            }

            NotifyAuthenticationStateChanged(Task.FromResult(new AuthenticationState(claimsPrincipal)));
        }

        public async Task Logout()
        {
            await UpdateAuthenticationState(null);
        }

        public async Task<bool> IsAuthenticated()
        {
            try
            {
                var userSessionResult = await sessionStorage.GetAsync<UserSession>("UserSession");
                var userSession = userSessionResult.Success ? userSessionResult.Value : null;
                return userSession != null;
            }
            catch
            {
                return false;
            }
        }

        public async Task<string?> GetEmail()
        {
            try
            {
                var userSessionResult = await sessionStorage.GetAsync<UserSession>("UserSession");
                var userSession = userSessionResult.Success ? userSessionResult.Value : null;

                return userSession?.Email;
            }
            catch
            {
                return null;
            }
        }

        public async Task<string?> GetTipo()
        {
            try
            {
                var userSessionResult = await sessionStorage.GetAsync<UserSession>("UserSession");
                var userSession = userSessionResult.Success ? userSessionResult.Value : null;

                return userSession?.Tipo;
            }
            catch
            {
                return null;
            }
        }
    }
}
