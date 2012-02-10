/*interface for using libvbucket*/
#include <libvbucket/vbucket.h>
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"


typedef struct {
    VBUCKET_CONFIG_HANDLE h;
    char **servers;
    int nservers;
} PLCBvb_t;

#define _self2obj(sv) (SvROK(sv) ? (NUM2PTR(PLCBvb_t*, SvIV(SvRV(sv))) ) \
    : (void*)die("I was passed an invalid object"))

SV *
PLCBvb_parse(const char *pkg, const char *str)
{
    VBUCKET_CONFIG_HANDLE h;
    SV *ret;
    PLCBvb_t *object;
    int i;
    
    h = vbucket_config_parse_string(str);
    if(h == NULL) {
        return &PL_sv_undef;
    }
    
    ret = newSV(0);
    Newx(object, 1, PLCBvb_t);
    
    object->h = h;
    object->servers = NULL;
    
    object->nservers = vbucket_config_get_num_servers(h);
    
    if(object->nservers) {
        Newxz(object->servers, object->nservers, char*);
        
        for(i = 0; i < object->nservers; ++i) {
            
            const char *server_str = vbucket_config_get_server(h, i);
            
            Newx(object->servers[i], strlen(server_str)+1, char);
            strcpy(object->servers[i], server_str);
        }
    }
        
    sv_setiv(newSVrv(ret, "Couchbase::VBucket"), PTR2IV(object));
    return ret;
}

void
PLCBvb_DESTROY(SV *self)
{
    int i;
    PLCBvb_t *object = _self2obj(self);
    
    if(!object) {
        return;
    }
    
    if(object->servers) {
        for(i = 0; i < object->nservers; i++) {
            Safefree(object->servers[i]);
        }
        Safefree(object->servers);
        object->servers = NULL;
    }
    if(object->h) {
        vbucket_config_destroy(object->h);
    }
    Safefree(object);
}

SV *
PLCBvb_map(SV *self, SV *key, char **srvptr, IV *idxptr)
{
    PLCBvb_t *object;
    int vbid, server_idx;
    STRLEN nkey;
    char *skey;
    
    object = _self2obj(self);
    skey = SvPV(key, nkey);
    if(!skey) {
        die("I was given an empty key");
    }
    if(vbucket_map(object->h, skey, nkey, &vbid, &server_idx) != 0) {
        *srvptr = NULL;
    }
    *idxptr = server_idx;
    *srvptr = object->servers[server_idx];    
}

AV *
PLCBvb_servers(SV *self)
{
    AV *ret;
    PLCBvb_t *object;
    int i;
    
    object = _self2obj(self);
    ret = newAV();
    for( i = 0; i < object->nservers; i++) {
        av_push(ret, newSVpv(object->servers[i], 0));
    }
    return ret;
}

AV *
PLCBvb_diff(SV *self, SV *other)
{
    AV *ret, *srv_removed, *srv_added;
    VBUCKET_CONFIG_DIFF *diff;
    PLCBvb_t *object, *other_obj;
    char **strp;

    object = _self2obj(self);
    other_obj = _self2obj(other);
    
    ret = newAV();
    srv_removed = newAV();
    srv_added = newAV();
    av_store(ret, 0, newRV_noinc((SV*)srv_added));
    av_store(ret, 1, newRV_noinc((SV*)srv_removed));

    diff = vbucket_compare(object->h, other_obj->h);
    
    if(!diff) {
        return ret;
    }
    
    for(strp = diff->servers_added; strp; strp++) {
        av_push(srv_added, newSVpv(*strp, 0));
    }
    for(strp = diff->servers_removed; strp; strp++) {
        av_push(srv_removed, newSVpv(*strp, 0));
    }
    vbucket_free_diff(diff);
    return ret;
}

MODULE = Couchbase::VBucket PACKAGE = Couchbase::VBucket PREFIX = PLCBvb_

PROTOTYPES: DISABLE

SV *
PLCBvb_parse(pkg, str)
    const char *pkg
    const char *str
    
void
PLCBvb_DESTROY(self)
    SV *self
    
void
PLCBvb_map(self, key)
    SV *self
    SV *key
    
    PREINIT:
    char *str;
    IV idx;
    
    PPCODE:
    PLCBvb_map(self, key, &str, &idx);
    if(!str) {
        XSRETURN_UNDEF;
        return;
    }
    
    XPUSHs(sv_2mortal(newSVpv(str, 0)));
    if(GIMME_V == G_ARRAY){
        XPUSHs(sv_2mortal(newSViv(idx)));
        XSRETURN(2);
    } else {
        XSRETURN(1);
    }
    return;
    
    
AV *
PLCBvb_servers(self)
    SV *self
    
AV *
PLCBvb_diff(self, other)
    SV *self
    SV *other